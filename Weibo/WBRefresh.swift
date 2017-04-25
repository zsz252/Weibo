//
//  WBRefresh.swift
//  Weibo
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

// 刷新状态变化临界值
private let WBRefreshOffset:CGFloat = 100

/// 刷新状态
///
/// - Normal:      普通状态，什么都不做
/// - Pulling:     超过临界点，如果放手，开始刷新
/// - willRefresh: 用户超过临界点，并且放手
enum WBRefreshState {
    case Normal
    case Pulling
    case willRefresh
}

/// 刷新控件 - 负责刷新相关的逻辑处理
class WBRefresh: UIControl {
    
    /// 刷新控件的父视图，下拉刷新控件应适用于 UITableView 和 UIColletionView
    private weak var scrollView:UIScrollView?
    
    lazy var refreshView = WBRefreshView.refreshView()
    
    //MARK: - 构造函数
    init() {
        super.init(frame: CGRect())
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    /**
    willMove: addSubview方法会调用
    当添加到父视图的时候，newsuperview是父视图
    当父视图被移除，newsuperview是nil
    */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 记录父视图
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        
        scrollView = sv
        
        // KVO监听父视图的 cotentOffset
        
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    override func removeFromSuperview() {
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //print(scrollView?.contentOffset)
        
        // 记录父视图
        guard let sv = scrollView else {
            return
        }
        
        // 刷新控件初始高度
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        if height < 0 {
            return
        }
        
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        //print(height)
        //判断临界点
        if sv.isDragging{
            
            if height > WBRefreshOffset && (refreshView.refreshState == .Normal){
                refreshView.refreshState = .Pulling

            }else if height <= WBRefreshOffset && (refreshView.refreshState == .Pulling){

                refreshView.refreshState = .Normal
            }
        }else{
            
            if refreshView.refreshState == .Pulling {
                refreshView.refreshState = .willRefresh
                
                //显示刷新视图
                var inset = sv.contentInset
                inset.top += WBRefreshOffset
                
                sv.contentInset = inset
            }
        }
    }
    
    //开始刷新
    func beginRefreshing(){
        
    }

    //结束刷新
    func endRefreshing(){
        
    }

}

extension WBRefresh{
    
    func setupUI(){
        backgroundColor = super.backgroundColor
        
        // 设置出边界不显示
        //clipsToBounds = true
        
        // 添加刷新视图
        addSubview(refreshView)
        
        // 自动布局 - 设置 xib 控件的自动布局，需要指定宽高约束
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.width))
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refreshView.bounds.height))
    }
    
}
