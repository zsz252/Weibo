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
    
    var refreshState:WBRefreshState = .Normal{
        didSet{
            switch refreshState {
            case .Normal:
                tipLable.text = "下拉开始刷新"
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon.transform = CGAffineTransform.identity
                })
                tipIcon.isHidden = false
                indicator.stopAnimating()
            case .Pulling:
                tipLable.text = "放手开始刷新"
                UIView.animate(withDuration: 0.25, animations: { 
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.0001))
                })
            case .willRefresh:
                tipLable.text = "正在刷新~"
                
                tipIcon.isHidden = true
                
                //显示菊花
                indicator.startAnimating()
            }
        }
    }
    
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
