
//
//  WBWelcomeView.swift
//  Weibo
//
//  Created by apple on 2017/2/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import SDWebImage
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
    
    // initWithCoder
    override func awakeFromNib() {
        // 1. url
        guard let urlString = WBNetworkManager.shared.userAccount.avatar_large else{
            return
        }
        let url = URL(string: urlString)
        // 2. 设置头像
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "profile"))
        
        iconView.layer.cornerRadius = 42.5
        iconView.layer.masksToBounds = true
    }
    
    /// 视图被添加到 window上
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 260
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: { 
                        //更新约束
                        self.layoutIfNeeded()
            }) { (_) in
                UIView.animate(withDuration: 1.0, animations: { 
                    self.tipLable.alpha = 1
                    }, completion: { (_) in
                        self.removeFromSuperview()
                })
        }
    }
}
