//
//  WBComposeTypeButton.swift
//  Weibo
//
//  Created by apple on 2017/5/7.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    
    /// 使用图像名称，标题创建按钮
    ///
    /// - parameter image: 图像
    /// - parameter lable: 标题
    ///
    /// - returns: 按钮
    class func composeTypeButton(imageName:String,lable:String) -> WBComposeTypeButton{
        
        let nib = UINib(nibName: "WBComposeTypeButton", bundle: nil)
        
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeButton
        
        btn.imageView.image = UIImage(named:imageName)
        
        btn.titleLable.text = lable
        
        return btn
    }
}
