
//
//  WBWelcomeView.swift
//  Weibo
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/// 欢迎视图
class WBWelcomeView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLable: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    class func welcomeView() -> WBWelcomeView{
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0]
        
//        v.frame = UIScreen.main().bounds
        
        return v as! WBWelcomeView
    }
    
    /// 视图被添加到 window上
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 200
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: { 
                        //更新约束
                        self.layoutIfNeeded()
            }) { (_) in
                
        }
    }
}
