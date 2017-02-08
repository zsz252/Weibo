//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    //访客视图字典信息
    var visitorInfo:[String:String]?
    //表格视图，如果用户名没有登录则没有
    var tableView:UITableView?
    //刷新控件
    var refreshControl:UIRefreshControl?
    //上拉刷新标记
    var isPullup = false
    
    //自定义导航
    var navigationBar:UINavigationBar?
    var navItem:UINavigationItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //取消自动缩进 - 如果隐藏导航栏会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
        WBNetworkManager.shared().userLogon ? loadDate() : ()
        // Do any additional setup after loading the view.
    }

    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
    
    func loadDate(){
        refreshControl?.endRefreshing()
    }
    
}
// MARK: - 访客视图监听方法
extension WBBaseViewController{
    func login(){
        print("用户登录")
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    func register(){
        print("用户注册")
    }
}
// MARK: - 设置ui
extension WBBaseViewController{
    
    func setupUI(){
        setipNavigationBar()
        
        WBNetworkManager.shared().userLogon ? setupTableView() : setupVisitorView()
    }
    //设置访客视图
    func setupVisitorView(){
        
        let visitorView = WBVisitorView(frame: self.view.bounds)
        
        view.insertSubview(visitorView, belowSubview: navigationBar!)
        //设置访客视图监听方法
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        //设置访客视图信息
        visitorView.visitorInfo = self.visitorInfo
        
        //设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }
    
    //设置表格视图
    func setupTableView(){
        tableView = UITableView(frame: self.view.bounds,style:.plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar!)
        
        //设置数据源和代理  目的：自类直接实现数据源方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: (navigationBar?.bounds.height)!, left: 0, bottom: (tabBarController?.tabBar.bounds.height)!, right: 0)
        
        //设置刷新控件
        refreshControl = UIRefreshControl()
        
        tableView?.addSubview(refreshControl!)
        //添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadDate), for: .valueChanged)
    }
    
    //设置导航条
    func setipNavigationBar(){
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        view.addSubview(navigationBar!)
        //导航栏添加item
        navigationBar?.items = [navItem]
        //设置navBar的渲染颜色
        navigationBar?.barTintColor = UIColor.white
        //设置navBar的字体颜色
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        //设置系统按钮的文字渲染颜色
        navigationBar?.tintColor = UIColor.orange
    }
    
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension WBBaseViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //1.判断是否是最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row<0 || section<0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullup{
            
            isPullup = true
            
            loadDate()
        }
    }
}
