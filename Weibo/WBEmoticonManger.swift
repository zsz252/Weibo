//
//  WBEmoticonManger.swift
//  Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

class WBEmoticonManager{
    
    // 为了便于表情的复用，建立一个单例，只加载一次表情管理
    // 表情管理器单例
    static let shared = WBEmoticonManager()
    
    // 表情包的懒加载数组
    lazy var packages = [WBEmoticonPackage]()
    
    // 构造函数，使用private使外部无法调用  OC 要重写 allocWithZone
    private init(){
        
    }
}

// MARK: - 表情符号处理
extension WBEmoticonManager{
    
    
    /// 根据字符串查找表情符号对应的表情模型
    ///
    /// - parameter string: 字符串
    ///
    /// - returns: 返回表情模型 可为nil
    func findEmoticon(string:String) -> WBEmoticon?{
        
        // 遍历表情包
        for p in packages{
            
            // 在表情数组中过滤string
            let result = p.emoticons.filter({ (em) -> Bool in
                return em.chs == string
            })
            
            // 判断数组的数量
            if result.count == 1{
                return result[0]
            }
        }
        
        return nil
    }
    
}

// MARK: - 表情包数据处理
extension WBEmoticonManager{
    
    func loadPackages(){
        
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
            let models = NSArray.yy_modelArray(with: WBEmoticonPackage.classForCoder(), json: array) as? [WBEmoticonPackage]
        else{
            return
            
        }
        
        // 设置表情包数据
        packages += models
        
        print(models)
    }
}
