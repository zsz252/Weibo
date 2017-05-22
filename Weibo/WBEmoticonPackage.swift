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
    var directory:String?{
        didSet{
            
            // 当设置目录时，从目录下加载plist
            guard let directory = directory,
                let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
                let bundle = Bundle(path: path),
                let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String:String]],
                let models = NSArray.yy_modelArray(with: WBEmoticon.classForCoder(), json: array) as? [WBEmoticon]
            else {
                return
            }
            
            // 遍历models数组 ，设置每一个表情符号的目录
            for m in models{
                m.directory = directory
            }
            
            emoticons += models
        
        }
    }
    
    // 懒加载表情包模型的空数组
    // 使用懒加载可避免后续解包
    lazy var emoticons = [WBEmoticon]()
    
    override var description: String{
        return yy_modelDescription()
    }
}
