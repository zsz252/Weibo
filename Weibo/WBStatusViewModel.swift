//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

class WBStatusViewModel{
    
    //微博模型
    var status:WBStatus
    
    
    /// 构造函数
    ///
    /// - parameter model: 微博模型
    ///
    /// - returns: 微博的视图模型
    init(model:WBStatus) {
        self.status = model
    }
}
