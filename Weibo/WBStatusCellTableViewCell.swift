//
//  WBStatusCellTableViewCell.swift
//  Weibo
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

@objc protocol WBStatusCellTableViewCellDelegate {
    @objc optional func statusCellDidSelectedURLString(cell:WBStatusCellTableViewCell,urlString:String)
}

class WBStatusCellTableViewCell: UITableViewCell {
    
    var delegate:WBStatusCellTableViewCellDelegate?
    // 视图模型
    var viewModel:WBStatusViewModel?{
        didSet{
            //微博文本
            statusLable.attributedText = viewModel?.statusAttrText
            //姓名
            nameLable.text = viewModel?.status.user?.screen_name
            //设置会员图标
            memberIconView.image = viewModel?.memberIcon
            //设置认证图标
            vipIconView.image = viewModel?.vipIcon
            //用户头像
            iconView.wb_setImage(urlString: (viewModel?.status.user?.profile_image_url)!, placeholderImage: UIImage(named: "profile_"),isAvatar: true)
            tarBar.viewModel = viewModel
            
            //配图视图视图模型
            pictureView.viewModel = viewModel
            //设置高度
            //pictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            //设置配图视图数据
            pictureView.urls = viewModel?.picURLs
            //设置被转发微博文字
            retweetedLable?.attributedText = viewModel?.retweetedAttrText
            //设置来源
            sourceLable.text = viewModel?.status.source
        }
    }
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLable: UILabel!
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLable: UILabel!
    /// 来源
    @IBOutlet weak var sourceLable: UILabel!
    /// 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    /// 微博正文
    @IBOutlet weak var statusLable: WBLable!
    //@IBOutlet weak var statusLable: UILabel!
    // 底部工具栏
    @IBOutlet weak var tarBar: WBStatusTarbar!
    // 配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    // 被转发微博的文字
    @IBOutlet weak var retweetedLable: WBLable!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，是滚动的这张图像
        self.layer.shouldRasterize = true
        
        // 使用 栅格化 注意重新指定分辨率 
        self.layer.rasterizationScale = UIScreen.main.scale
        
        statusLable.delegate = self
        retweetedLable.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension WBStatusCellTableViewCell:WBLableDelegate{
    
    func lableDidSelectedLinkText(lable: WBLable, text: String) {
        
        delegate?.statusCellDidSelectedURLString?(cell: self, urlString: text)
    }
    
}
