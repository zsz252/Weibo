//
//  AppDelegate.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //取得用户授权显示通知[上方的提示条/声音/BadgeNumber]
        // 10.0 以上
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (sucess, error) in
            
        }
        // 10.0 以下
//        let notifySettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
//        application.registerUserNotificationSettings(notifySettings)
        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = WBMainViewController()
        
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }


}

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
