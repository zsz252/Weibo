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
    
    
    //来源字符串
    //var sourceStr:String?
    
    var pictureViewSize = CGSize()
    
    //如果是被转发的微博，原创微博一定没有图
    var picURLs: [WBStatusPicture]?{
        //如果有被转发微博，返回被转发微博的配图
        //如果没有被转发微博，返回原创微博的配图
        //如果都没有，返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    //微博正文的属性文本
    var statusAttrText:NSAttributedString?
    //被转发微博文字
    var retweetedAttrText:NSAttributedString?
    
    //行高
    var rowHeight:CGFloat = 0
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
        
        
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetFont = UIFont.systemFont(ofSize: 14)
        
        //微博正文属性文本
        statusAttrText = WBEmoticonManager.shared.emoticonString(string: model.text ?? "", font: originalFont)
        
        // 设置被转发微博的文字
        let rText = "@" + (status.retweeted_status?.user?.screen_name ?? "") + ":" + (status.retweeted_status?.text ?? "")
        
        retweetedAttrText = WBEmoticonManager.shared.emoticonString(string: rText, font: retweetFont)
        // 设置来源字符串
        //sourceStr = "来自" + (model.source?.wb_href()?.text ?? "")
        
        // 计算行高
        updateRowHeight()
    }
    
    var description: String{
        return status.description
    }
    
    func updateSingleImageSize(image:UIImage){
        
        var size = image.size
        
        // 过宽图像处理
        let maxWidth:CGFloat = 300
        let minWidth:CGFloat = 40
        
        if size.width > maxWidth {
            size.width = maxWidth
            
            size .height = size.width + image.size.height / image.size.width / 4
        }
        
        // 过窄图像处理
        if size.width < minWidth{
            size.width = minWidth
            
            size .height = size.width + image.size.height / image.size.width
        }
        
        size.height += WBStatusPictureViewOutterMargin
        
        pictureViewSize = size
        
        //更新行高
        updateRowHeight()
    }
    
    
    /// 根据当前视图模型计算行高
    func updateRowHeight(){
        
        let margin:CGFloat = 12
        let iconHeight:CGFloat = 34
        let toolbarHeight:CGFloat = 35
        
        var height:CGFloat = 0
        
        let viewSize = CGSize(width: UIScreen.main.bounds.size.width - 2 * margin, height: CGFloat(MAXFLOAT))
       
        
        //计算顶部位置
        height = 2 * margin + iconHeight + margin
        
        //正文高度
        if let text = statusAttrText{
            height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
        }
        
        //判断是否转发微博
        if status.retweeted_status != nil{
            height += 2 * margin
            
            if let text = retweetedAttrText{
                height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
            }
        }
        
        //配图视图
        height += pictureViewSize.height
        height += margin
        
        //底部工具栏
        height += toolbarHeight
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
