
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
    
    //被转发的原创微博
    var retweeted_status:WBStatus?
    
    //微博配图模型数组
    var pic_urls:[WBStatusPicture]?
    
    //重写 description 的计算性属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 类函数 -> 使用第三方框架 YY_Model 如果遇到数组类型的属性，数组中存放的对象是什么类
    // NSArray 中保存对象通常是id类型
    class func modelContainerPropertyGenericClass() -> [String:AnyClass]{
        return ["pic_urls":WBStatusPicture.classForCoder()]
    }
}
