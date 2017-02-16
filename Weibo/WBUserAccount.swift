//
//  WBUserAccount.swift
//  Weibo
//
//  Created by apple on 2017/2/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
private let accountFile = "useraccount.json"

class WBUserAccount: NSObject {

    //访问令牌
    var access_token:String?
    //用户代号
    var uid:String?
    //过期日期（单位秒）
    var expires_in:TimeInterval = 0.0{
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    var expiresDate:Date?
    
    //用户昵称
    var screen_name:String?
    //用户头像
    var avatar_large:String?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        // 从磁盘加载保存的文件 -> 字典
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let Path = (docDir as NSString).appendingPathComponent(accountFile)
    
        guard let data = NSData(contentsOfFile: Path),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject]
        else {
            return
        }
        // 使用字典设置属性值
        //yy_modelSet(with: dict ?? [:])
        
        // 判断token是否过期
        if expiresDate?.compare(Date()) != .orderedDescending{
            
            access_token = nil
            uid = nil
            
            //删除用户文件
            try? FileManager.default.removeItem(atPath: Path)
            
        }
    }
    
    /// 1.偏好设置(小)
    /// 2.沙盒 - 归档/plist/json
    /// 3.数据库(FMDB/CoreData)
    /// 4.钥匙串访问(小，自动加密 - 需要使用框架 SSKeychain)
    func saveAccount(){
        // 1. 模型转字典
        
        var dict = (self.yy_modelToJSONObject() as? [String:AnyObject]) ?? [:]
        
        _ = dict.removeValue(forKey: "expires_in")
        // 2. 字典序列号 data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])else {
            return
        }
        // 3. 写入磁盘
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(accountFile)
        print(filePath)
        
        (data as NSData).write(toFile: filePath, atomically: true)
    }
}
