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
        
        // 隐藏按钮
        enterButton.isHidden = true
    }
}
