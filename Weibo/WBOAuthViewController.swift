//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by apple on 2017/1/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import SVProgressHUD

//通过 webView 加载新浪微博授权登录页面
class WBOAuthViewController: UIViewController {
    
    lazy var webView = UIWebView()
    
    //更换根视图
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        //取消滚动视图
        webView.scrollView.isScrollEnabled = false
        
        //设置代理
        webView.delegate = self
        
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBack: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
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
    
    
    /// 自动填充 - webView 的注入
    func autoFill(){
        
        // 准备 js
        let js = "document.getElementById('userId').value = '15881126068' ;" +
            "document.getElementById('passwd').value = '252252299' ;"
        
        // 让 webView 执行
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    func close(){
        SVProgressHUD.dismiss()
        dismiss(animated: true) { 
            
        }
    }
}

extension WBOAuthViewController:UIWebViewDelegate{
    
    /// webView将要加载请求
    ///
    /// - parameter webView:        webView
    /// - parameter request:        要加载的请求
    /// - parameter navigationType: 导航类型
    ///
    /// - returns: 是否加载 request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.url?.absoluteString.hasPrefix(WBRedirectURL) == false {
            return true
        }
        
        if request.url?.query?.hasPrefix("code=") == false {
            close()
            return false
        }
        
        //  取出授权码
        let code = request.url?.query?.substring(from: "code=".endIndex)
        
        WBNetworkManager.shared().loadAccessToken(code: code!)
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
