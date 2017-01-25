//
//  WBVisitorView.swift
//  Weibo
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/// 访客视图
class WBVisitorView: UIView {
    
    //访客视图信息字典
    var visitorInfo:[String:String]?{
        didSet{
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else{
                    return
            }
            
            tipLable.text = message
            
            if imageName == "" {
                return
            }
            iconView.image = UIImage(named: imageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 控件
    var iconView = UIImageView(image: UIImage(named: "homeBG"))
    
    var tipLable = UILabel()
    
    var registerButton = UIButton()
    
    var loginButton = UIButton()
}

extension WBVisitorView{
    
    func setupUI(){
        backgroundColor = UIColor.white
        
        tipLable.font = UIFont.systemFont(ofSize: 14)
        tipLable.text = "关注一些人，回这里看看有什么惊喜"
        tipLable.textColor = UIColor.red
        tipLable.numberOfLines = 0
        tipLable.textAlignment = .center
        
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        registerButton.setTitleColor(UIColor.orange, for: .normal)
        registerButton.setTitleColor(UIColor.black, for: .highlighted)
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.borderWidth = 2
        registerButton.layer.cornerRadius = 16
        registerButton.layer.masksToBounds = true
        
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.setTitleColor(UIColor.green, for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .highlighted)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 16
        loginButton.layer.masksToBounds = true
        
        addSubview(iconView)
        addSubview(tipLable)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //自动布局
        
        //1.图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 150))
        //2.提示标签
       addConstraint(NSLayoutConstraint(item: tipLable,
                                        attribute: .centerX,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .centerX,
                                        multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLable,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLable,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0, constant: 240))
        //3.注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top, relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 30))
        
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        //登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLable,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 30))
        
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
    }
    
}
