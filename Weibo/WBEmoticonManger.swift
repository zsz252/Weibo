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
    
    // 构造函数，使用private使外部无法调用  OC 要重写 allocWithZone
    private init(){
        
    }
}

// MARK: - 表情包数据处理
extension WBEmoticonManager{
    
    func loadPackages(){
        
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String:String]]
        else{
            return
            
        }
        
        
    }
}
