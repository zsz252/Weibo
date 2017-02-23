//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }
    
}

extension WBStatusPictureView{
    
    func setupUI(){
        
        // 超出边界的内容不显示
        clipsToBounds = true
        
        let rect = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWidth, height: WBStatusPictureItemWidth)
        // 循环创建 9 个 imageView
        for i in 0..<9{
            let iv = UIImageView(frame: rect)
            
            iv.backgroundColor = UIColor.blue
            
            // 行
            let row = CGFloat(i / 3)
            // 列
            let col = CGFloat(i % 3)
            
            let xOffset = col * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            
            let yOffset = row * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            addSubview(iv)
        }
        
    }
    
}
