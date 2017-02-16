//
//  WBNetworkManager+Extension.swift
//  Weibo
//
//  Created by apple on 2017/1/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation


// MARK: - 封装新浪微博的网络请求方法
extension WBNetworkManager{
    
    func statusList(since_id:Int64 = 0,max_id:Int64 = 0,completion: @escaping (_ list: [[String:Any]], _ isSucess: Bool )->()){
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["since_id":"\(since_id)","max_id":"\(max_id > 0 ? max_id-1 : 0)"]
        
        tokenRequest(URLString: urlString, parameters: params) { (json, isSucess) in
            
            let result = (json as? [String:Any])?["statuses"] as? [[String:Any]]
            
            completion(result ?? [], isSucess)
        }
    }
    
    
    /// 返回未读微博数量
    func unreadCount(completion: @escaping (_ count:Int)->()){
        
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        
        let params = ["uid":"\(uid)"]
        
        tokenRequest(URLString: urlString, parameters: params) { (json, isSucess) in
            
            let dict = json as? [String:AnyObject]
            let count = dict?["status"] as? Int ?? 0
            completion(count)
    
        }
    }
}


// MARK: - 微博用户信息
extension WBNetworkManager{
    
    
    /// 加载用户信息
    func loadUserInfo(completion: @escaping (_ dict: [String:AnyObject])->()){
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["uid":userAccount.uid]
        
        tokenRequest(URLString: urlString, parameters: params) { (json, isSuccess) in
            completion(json as? [String:AnyObject] ?? [:])
        }
        
    }
}

// MARK: - OAuth相关方法
extension WBNetworkManager{
    
    /// 加载 AccessToken
    ///
    /// - parameter code:       授权码
    /// - parameter completion: 完成回调(是否成功)
    func loadAccessToken(code:String, completion: @escaping (_ isSucess:Bool)->()){
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id": WBAppKey,
                      "client_secret": WBAppSecret,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": WBRedirectURL]
        
        //发起网络请求
        request(method: .POST, URLString: urlString, parameters: params) { (json, isSucess) in
            //如果请求失败，对用户数据不会有任何影响
            //直接用字典设置 userAccount 的 属性
            self.userAccount.yy_modelSet(with: (json as? [String:AnyObject]) ?? [:])
            
            print(self.userAccount)
            //加载用户信息
            self.loadUserInfo(completion: { (dict) in
                print(dict)
                // 使用用户信息字典 设置用户账户信息
                self.userAccount.yy_modelSet(withJSON: dict)
                // 保存用户模型
                self.userAccount.saveAccount()
                //完成回调
                completion(isSucess)
            })
            

        }
    }
    
}
