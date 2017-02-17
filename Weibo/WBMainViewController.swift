//
//  WBMainViewController.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBMainViewController: UITabBarController {
    
    //定时器
    var timer:Timer?
    
    var composeButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpChildControllers()
        setUpComposeButton()
        setupTimer()
        
        //新特性视图
        setupNewfeatureView()
        //设置代理
        delegate = self
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(n:)), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    //利用 @objc private 保护函数，同时允许按钮调用
    func compseStatus(){
        print("撰写微博")
    }
    
    //使用代码控制屏幕方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    //用户登录通知执行
    func userLogin(n:Notification){
        
        var when = DispatchTime.now()
        
        if n.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，需重新登录")
            //修改延迟时间
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            //展现登录视图
            let vc = UINavigationController(rootViewController: WBOAuthViewController())
            
            self.present(vc, animated: true) {
                
            }
        }
    }
    
    deinit {
        //销毁定时器
        timer?.invalidate()
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - UITabBarControllerDelegate 使中间按钮不会跳转
extension WBMainViewController:UITabBarControllerDelegate{
    
    /// 将要选择 TabBarItem
    ///
    /// - parameter tabBarController: tabBarController
    /// - parameter viewController:   目标控制器
    ///
    /// - returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let idx = childViewControllers.index(of: viewController)
        
        if idx == 0 && idx == selectedIndex {
            //获取控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            //让表格滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x:0,y:-64), animated: true)
            
            //刷新表格数据
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadDate()
            })
        }
        
        return !viewController.isMember(of: UIViewController.classForCoder())
    }
}

// MARK: - 定时器设置
extension WBMainViewController{
    func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer(){
        
        if WBNetworkManager.shared.userLogon {
            return
        }
        
        WBNetworkManager.shared.unreadCount { (count) in
            
            //设置首页的badageNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            //设置应用的badageNumber
            UIApplication.shared.applicationIconBadgeNumber = count
        }
        
    }
}


// MARK: - 新特性视图
extension WBMainViewController{
    
    func setupNewfeatureView(){
        
        // 0. 判断是否登录
        if !WBNetworkManager.shared.userLogon{
            return
        }
        
        // 1. 检测版本是否更新
        
        // 2. 如果更新，显示新特性，否则显示欢迎
        let v = isNewVersion ? WBNewFeatureView.newFeatureView() : WBWelcomeView.welcomeView()
        // 3. 添加视图
        v.frame = view.bounds
        
        view.addSubview(v)
    }
    
    var isNewVersion: Bool{
        let path = "version"
        // 1. 取当前的版本号
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        // 2. 取保存在 Document 目录中的之前版本号
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = (docDir as NSString).appendingPathComponent(path)
        
        let lastVersion = (try? String(contentsOfFile: filePath)) ?? ""
        print(filePath)
        // 3. 将当前版本号保存
        try? currentVersion.write(toFile: filePath, atomically: true, encoding: .utf8)
        // 4. 判断版本号
        return true//currentVersion != lastVersion
    }
}

// MARK: - ui设置
extension WBMainViewController{
    
    func setUpComposeButton(){
        composeButton = UIButton()
        composeButton?.setImage(UIImage(named:"composeButton"), for: .normal)
        
        let count = CGFloat((viewControllers?.count)!)
        let w = tabBar.bounds.width / count - 1
        //dy为负可以向上凸出
        composeButton?.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        tabBar.addSubview(composeButton!)
        
        composeButton?.addTarget(self, action: #selector(compseStatus), for: .touchUpInside)
    }
    
    func setUpChildControllers(){
        
        //0.获取沙盒的json路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        
        //判断data是否有内容，如果没有，说明本地沙盒没有文件
        if data == nil {
            //从bundle加载data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        //从bundle 加载 json
        //1.路径 2.加载nsdata 3.反序列化转换为数组
        guard let array = try? JSONSerialization.jsonObject(with: data as! Data, options: []) as? [[String:Any]]
            else{
                return
        }
        
//        let array = [
//            ["clsName":"WBHomeViewController","title":"首页","imageName":"home",
//                "visitorInfo":["imageName":"","message":"关注一些人，回这里看看有什么惊喜"]
//            ],
//            ["clsName":"WBMessageViewController","title":"消息","imageName":"message",
//                "visitorInfo":["imageName":"messageBG","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]
//            ],
//            ["clsName":"UIViewController"],
//            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover",
//                "visitorInfo":["imageName":"discoverBG","message":"登陆后，最新、最热微博尽在掌握，不会再与事实潮流擦肩而过"]
//            ],
//            ["clsName":"WBProfileViewController","title":"我","imageName":"profile",
//                "visitorInfo":["imageName":"profileBG","message":"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人"]
//            ]
//        ]
        
        //(array as NSArray).write(toFile: "", atomically: true)
        //数组json化
//        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        (data as NSData).write(toFile: "/Users/apple/Desktop/main.json", atomically: true)
        
        //遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        
        //设置tabbar子控制器
        viewControllers = arrayM
        
    }
    
    private func controller(dict:[String:Any]) -> UIViewController {
        
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String ,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? WBBaseViewController.Type,
            let visitorDist = dict["visitorInfo"] as? [String:String]
        else {
            return UIViewController()
        }
        
        let vc = cls.init()
        //设置访客视图
        vc.visitorInfo = visitorDist
        //设置图像，字体
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_")?.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        
        let nav = WBNavigationViewController(rootViewController: vc)
        
        return nav
    }
    
}
