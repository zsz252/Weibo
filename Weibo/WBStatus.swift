
//
//  WBStatus.swift
//  Weibo
//
//  Created by apple on 2017/1/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import YYModel

//微博数据模型
class WBStatus: NSObject {
    //微博id
    var id:Int64 = 0
    //微博信息内容
    var text:String?
    
    // 转发数
    var reposts_count:Int = 0
    // 评论数
    var comments_count:Int = 0
    // 点赞数
    var attitudes_count:Int = 0
    
    //微博的用户
    var user:WBUser?
    
    //重写 description 的计算性属性
    override var description: String{
        return yy_modelDescription()
    }
}
