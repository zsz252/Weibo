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
    
    var pictureViewSize = CGSize()
    
    //如果是被转发的微博，原创微博一定没有图
    var picURLs: [WBStatusPicture]?{
        //如果有被转发微博，返回被转发微博的配图
        //如果没有被转发微博，返回原创微博的配图
        //如果都没有，返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
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
        
        pictureViewSize = calcPictureViewSize(count: (picURLs?.count)!)
    }
    
    var description: String{
        return status.description
    }
    
    /// 计算指定数量的图片对应的配图视图的大小
    ///
    /// - parameter count: 配图数量
    ///
    /// - returns: 配图视图的大小
    func calcPictureViewSize(count:Int?) -> CGSize {
        if count == 0 || count == nil{
            return CGSize()
        }
        
        //  计算行数
        let row = (count! - 1) / 3 + 1
        // 根据行数算高度
        let height = WBStatusPictureViewOutterMargin + CGFloat(row) * WBStatusPictureItemWidth + CGFloat(row - 1) * WBStatusPictureViewInnerMargin
        
        return CGSize(width: 0, height: height)
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
