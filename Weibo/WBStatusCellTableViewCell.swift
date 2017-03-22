//
//  WBStatusCellTableViewCell.swift
//  Weibo
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBStatusCellTableViewCell: UITableViewCell {
    
    // 视图模型
    var viewModel:WBStatusViewModel?{
        didSet{
            //微博文本
            statusLable.text = viewModel?.status.text
            //姓名
            nameLable.text = viewModel?.status.user?.screen_name
            //设置会员图标
            memberIconView.image = viewModel?.memberIcon
            //设置认证图标
            vipIconView.image = viewModel?.vipIcon
            //用户头像
            iconView.wb_setImage(urlString: (viewModel?.status.user?.profile_image_url)!, placeholderImage: UIImage(named: "profile_"),isAvatar: true)
            tarBar.viewModel = viewModel
            
            //设置高度
            pictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            //设置配图视图数据
            pictureView.urls = viewModel?.picURLs
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
    @IBOutlet weak var statusLable: UILabel!
    // 底部工具栏
    @IBOutlet weak var tarBar: WBStatusTarbar!
    // 配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
