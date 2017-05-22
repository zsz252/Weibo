//
//  WBEmoticon.swift
//  Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBEmoticon: NSObject {

    // 表情类型 false - 图片表情  true - emoji
    var type = false
    // 表情字符串
    var chs:String?
    // 表情图片名称，用于本地图文混排
    var png:String?
    // emoj的十六进制编码
    var code:String?
    
    // 表情模型目录
    var directory:String?
    
    // 图片表情对应图像
    var image:UIImage?{
        
        // 判断表情类型
        if type{
            return nil
        }
        
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path)
            else {
            return nil
        }
        
        let image = UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
        
        return image
    }
    
    // 将当前的图像转换生成图像的属性文本
    func imageText(font:UIFont) -> NSAttributedString {
        
        // 判断图像是否存在
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        // 返回图像属性文本
        return NSAttributedString(attachment: attachment)
        
    }
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
