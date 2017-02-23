//
//  WBStatusTarbar.swift
//  Weibo
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBStatusTarbar: UIView {
    
    var viewModel:WBStatusViewModel?{
        didSet{
            retweetedButton.setTitle(viewModel?.retweetedStr, for: .normal)
            commentButton.setTitle(viewModel?.commentStr, for: .normal)
            likeButton.setTitle(viewModel?.likeStr, for: .normal)
        }
    }
    
    // 转发
    @IBOutlet weak var retweetedButton: UIButton!
    // 评论
    @IBOutlet weak var commentButton: UIButton!
    // 点赞
    @IBOutlet weak var likeButton: UIButton!

}
