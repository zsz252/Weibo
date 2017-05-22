//
//  WBEmoticonPackage.swift
//  
//
//  Created by apple on 2017/5/22.
//
//

import UIKit

//表情包模型
class WBEmoticonPackage: NSObject {
    
    // 表情包的分组名
    var groupName:String?
    
    // 表情包目录 , 从目录下加载 info.plist
    var directory:String?
    
    // 懒加载表情包模型的空数组
    // 使用懒加载可避免后续解包
    lazy var emoticons = [WBEmoticon]()
    
    override var description: String{
        return yy_modelDescription()
    }
}
