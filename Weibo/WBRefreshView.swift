//
//  WBRefreshView.swift
//  refresh
//
//  Created by apple on 2017/4/23.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/// 刷新视图 - 负责刷新相关的 UI显示 和 动画
class WBRefreshView: UIView {
    
    var refreshState:WBRefreshState = .Normal
    
    // 提示标签
    @IBOutlet weak var tipIcon: UIImageView!
    // 提示图标
    @IBOutlet weak var tipLable: UILabel!
    // 提示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    class func refreshView() -> WBRefreshView {
    
        let nib = UINib(nibName: "WBRefresh", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! WBRefreshView
    
    }
}
