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
        
        guard let uid = uid else {
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
