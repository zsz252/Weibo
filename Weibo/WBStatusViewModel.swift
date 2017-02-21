//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
import UIKit
class WBStatusViewModel: CustomStringConvertible{
    
    //微博模型
    var status:WBStatus
    
    //会员图标
    var memberIcon:UIImage?
    //认证类型
    var vipIcon:UIImage?
    
    /// 构造函数
    ///
    /// - parameter model: 微博模型
    ///
    /// - returns: 微博的视图模型
    init(model:WBStatus) {
        self.status = model
        
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7{
            let imageName = "vip"
            
            memberIcon = UIImage(named: imageName)
        }
        
        if model.user?.verified_type != -1 {
            vipIcon = UIImage(named: "avatar_vip")
        }
    }
    
    var description: String{
        return status.description
    }
}
