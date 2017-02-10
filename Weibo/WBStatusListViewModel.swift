//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by apple on 2017/1/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

class WBStatusListViewModel {
    
    //微博数据模型懒加载
    lazy var statusList = [WBStatus]()
    
    func loadStatus(pullup:Bool,completion: @escaping (_ isSucess:Bool)->()){
        
        
        let since_id = pullup ? 0 : (self.statusList.first?.id ?? 0)
        
        let max_id = pullup ? (self.statusList.last?.id) ?? 0 : 0
        
        WBNetworkManager.shared.statusList(since_id:since_id,max_id: max_id)  { (list, isSucess) in
            
            //字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.classForCoder(), json: list) as? [WBStatus] else {
                return
            }
            
            //拼接数据
            pullup ? (self.statusList += array) : (self.statusList = array + self.statusList)
            
            //完成回调 网络请求是否成功
            completion(isSucess)
        }
    }
}
