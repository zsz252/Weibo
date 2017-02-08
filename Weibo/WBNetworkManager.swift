//
//  WBNetworkManager.swift
//  Weibo
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}


//网络管理工具类
class WBNetworkManager: AFHTTPSessionManager {
    
    //访问令牌
    var accessToken:String? //= "2.00k1ajjFGYWF9C68df6b25f1SWmjvB"
    //用户id
    var uid:String?
    //用户登录标记
    var userLogon:Bool{
        return accessToken != nil
    }
    //单例模式
    static let shared = { () -> WBNetworkManager in  
        let instance = WBNetworkManager()
        
        //设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
    }
    
    //负责拼接 token 的网络请求方法
    func tokenRequest(method:WBHTTPMethod = .GET ,URLString:String , parameters: [String:Any]?, completion: @escaping (_ json:Any?,_ isSucess:Bool)->()){
        
        guard let token = accessToken else {
            completion(nil, false)
            
            return
        }
        
        //处理 token 字典
        var parameters = parameters
        if parameters == nil{
            parameters = [String:AnyObject]()
        }
        parameters!["access_token"] = token
        
        //调用 request 发起真正的网络请求
        request(URLString: URLString, parameters: parameters, completion: completion)
    }
    
    /// 封装AFN GET/POST 请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  地址
    /// - parameter parameters: 参数字典
    /// - parameter completion: 回调闭包
    func request(method:WBHTTPMethod = .GET ,URLString:String , parameters: [String:Any]?, completion: @escaping (_ json:Any?,_ isSucess:Bool)->()){
        
        let success = { (task:URLSessionDataTask,json:Any?)->() in
            completion(json, true)
        }
        
        let failure = { (task:URLSessionDataTask?,error:Error)->() in
            
            //针对 403 处理用户token过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token过期")
            }
            
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
