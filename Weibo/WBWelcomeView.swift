
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

    class func welcomeView() -> WBWelcomeView{
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0]
        
//        v.frame = UIScreen.main().bounds
        
        return v as! WBWelcomeView
    }
}
