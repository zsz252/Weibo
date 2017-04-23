//
//  WBRefresh.swift
//  Weibo
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/// 刷新控件
class WBRefresh: UIControl {
    
    /// 刷新控件的父视图，下拉刷新控件应适用于 UITableView 和 UIColletionView
    private weak var scrollView:UIScrollView?
    
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
        
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)

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
        backgroundColor = UIColor.orange
    }
    
}
