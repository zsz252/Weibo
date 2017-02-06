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

        // 加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURL)"
        // 1> 确定要访问的资源
        let url = URL(string: urlString)
        // 2> 建立请求
        let request = URLRequest(url: url!)
        // 3> 加载请求
        webView.loadRequest(request)
    }

    func close(){
        dismiss(animated: true) { 
            
        }
    }
}
