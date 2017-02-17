//
//  WBNewFeatureView.swift
//  Weibo
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/// 新特性视图
class WBNewFeatureView: UIView {

    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// 进入微博
    @IBAction func enterStauts(_ sender: AnyObject) {
        removeFromSuperview()
    }
    
    class func newFeatureView() -> WBNewFeatureView{
        
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0]
        
        //        v.frame = UIScreen.main().bounds
        
        return v as! WBNewFeatureView
    }
    
    override func awakeFromNib() {
        // 自动布局设置的界面，从xib加载默认是600 * 600 大小
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 1...count{
            let imageName = "new\(i)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i-1) * rect.width , dy: 0)
            
            scrollView.addSubview(iv)
        }
        
        // 指定scrollview属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.delegate = self
        // 隐藏按钮
        enterButton.isHidden = true
    }
}

extension WBNewFeatureView:UIScrollViewDelegate{
    
    // 减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 1. 滚动到最后一屏，让视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 2. 判断是否最后一页
        if page == scrollView.subviews.count{
            removeFromSuperview()
        }
        
        // 3. 如果是倒数第二页，显示按钮
        enterButton.isHidden = (page != scrollView.subviews.count - 1)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0. 一旦滚动，隐藏按钮
        enterButton.isHidden = true
        
        // 1. 计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5 )
        
        // 2. 设置分页控件
        pageControl.currentPage = page
        
        // 3. 分页控件的隐藏
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
