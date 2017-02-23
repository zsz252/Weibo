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
    
    //转发文字
    var retweetedStr:String?
    //评论文字
    var commentStr:String?
    //点赞文字
    var likeStr:String?
    
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
        
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "点赞")
    }
    
    var description: String{
        return status.description
    }
    
    
    /// 返回数值
    ///
    /// - parameter count:   数值
    /// - parameter default: 若无文字,默认文字
    ///
    /// - returns: 显示文字
    func countString(count:Int,defaultStr:String) -> String {
        
        if count == 0{
            return defaultStr
        }
        
        if count < 10000{
            return count.description
        }
        
        return String(format: "%.02f万", Double(count)/10000)
    }
}
