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
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
