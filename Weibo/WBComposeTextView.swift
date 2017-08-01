//
//  WBComposeTextView.swift
//  Weibo
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBComposeTextView: UITextView {

    lazy var placeholderLable = UILabel()
    
    override func awakeFromNib() {
        setupUI()
    }
    
}

extension WBComposeTextView{
    
    func setupUI(){
        
        placeholderLable.text = "分享新鲜事..."
        placeholderLable.font = self.font
        placeholderLable.textColor = UIColor.lightGray
        placeholderLable.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLable.sizeToFit()
        
        self.addSubview(placeholderLable)
    }
}
