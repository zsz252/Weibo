//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by apple on 2017/1/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

//通过 webView 加载新浪微博授权登录页面
class WBOAuthViewController: UIViewController {
    
    lazy var webView = UIWebView()
    
    //更换根视图
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBack: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func close(){
        dismiss(animated: true) { 
            
        }
    }
}
