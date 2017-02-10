//
//  AppDelegate.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupAdditions()
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = WBMainViewController()
        
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }


}


// MARK: - 设置应用程序额外信息
extension AppDelegate{
    
    func setupAdditions(){
        // 1. 设置 SVProgressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        // 2. 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 3. 设置用户授权通知
        //取得用户授权显示通知[上方的提示条/声音/BadgeNumber]
        // 10.0 以上
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (sucess, error) in
            
        }
        // 10.0 以下
        //        let notifySettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
        //        application.registerUserNotificationSettings(notifySettings)
        
    }
    
}

// MARK: - 从服务器加载应用程序信息
extension AppDelegate{
    
    func loadAppInfo(){
        
        DispatchQueue.global().async {
            
            //1.取url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            //2.得到数据
            let data = NSData(contentsOf: url!)
            //3.写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            //直接保存在本地沙盒
            print(jsonPath)
            data?.write(toFile: jsonPath, atomically: true)
        }
        
    }
    
}
