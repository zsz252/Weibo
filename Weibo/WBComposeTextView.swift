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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textChanged(n:Notification){
        //如果有文本，不显示占位标签，否则显示
        placeholderLable.isHidden = self.hasText
    }
    
}

extension WBComposeTextView{
    
    func setupUI(){
        
        //0.注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(n:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        
        //1.设置占位标签
        placeholderLable.text = "分享新鲜事..."
        placeholderLable.font = self.font
        placeholderLable.textColor = UIColor.lightGray
        placeholderLable.frame.origin = CGPoint(x: 5, y: 8)
        placeholderLable.sizeToFit()
        
        self.addSubview(placeholderLable)
    }
}
