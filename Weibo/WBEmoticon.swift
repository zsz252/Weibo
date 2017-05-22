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
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
