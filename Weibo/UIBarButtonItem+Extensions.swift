//
//  UIBarButtonItem+Extensions.swift
//  Weibo
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit


// MARK: - 便利构造item
extension UIBarButtonItem{
    
    convenience init(title:String,fontSize:CGFloat = 16,target:AnyObject,action:Selector,isBack:Bool = false){
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if isBack == true{
            btn.setImage(UIImage(named:"leftItem"), for: .normal)
            btn.setImage(UIImage(named:"leftItem_"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        self.init(customView:btn)
    }
    
}
