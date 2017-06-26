//
//  WBWebViewController.swift
//  Weibo
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBWebViewController: WBBaseViewController {

    lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    
    var urlString:String?{
        didSet{
            
            guard let urlString = urlString,
                let url = URL(string: urlString)
                else {
                    return
            }
            
            let urlRequest = URLRequest(url: url)
            
            webView.loadRequest(urlRequest)
        }
    }
}

extension WBWebViewController{
    
    override func setupTableView() {
        
        navItem.title = "网页"
        
        // 设置 webView
        view.insertSubview(webView, belowSubview: navigationBar!)
        
        // 设置 contentInset
        webView.scrollView.contentInset.top = (navigationBar?.bounds.height)!
    }
    
}
