//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

//定义全局常量
// 原创微博可重用 cell id
private let originalCellId = "originalCellId"
private let retweetedCellId = "retweetedCellId"

class WBHomeViewController: WBBaseViewController {
    
    lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //加载数据
    override func loadDate() {
        
        listViewModel.loadStatus(pullup: self.isPullup) { (isSucess) in
            
            self.refreshControl?.endRefreshing()
            
            self.isPullup = false
            
            self.tableView?.reloadData()
        }
        
        //模拟延时加载
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            
//            for i in 1...15{
//                //将数据插入数组顶部
//                if self.isPullup {
//                    //将数据加入数组底部
//                    self.statusList.append(i.description)
//                }else{
//                    //将数据加入数组顶部
//                    self.statusList.insert(i.description, at: 0)
//                }
//            }
//            //结束刷新控件
//            self.refreshControl?.endRefreshing()
//            
//            //恢复上拉标记
//            self.isPullup = false
//            
//            self.tableView?.reloadData()
//        }
    }
    
    //显示好友
    func showFriends(){
        navigationController?.pushViewController(WBDemoViewController(), animated: true)
    }
}


// MARK: - 表格数据源方法
extension WBHomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = listViewModel.statusList[indexPath.row]
        
        let cellId = (viewModel.status.retweeted_status != nil) ? retweetedCellId : originalCellId
        //1.取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WBStatusCellTableViewCell
        //2.设置cell
        cell.viewModel = viewModel
        //设置代理
        cell.delegate = self
        //3.返回cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = listViewModel.statusList[indexPath.row]
        
        //返回计算好的行高
        return vm.rowHeight
    }
}

// MARK: - 设置cell代理
extension WBHomeViewController:WBStatusCellTableViewCellDelegate{
    
    func statusCellDidSelectedURLString(cell: WBStatusCellTableViewCell, urlString: String) {
        
        let vc = WBWebViewController()
        
        vc.urlString = urlString
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - 设置界面
extension WBHomeViewController{
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        // 注册原型 cell
        tableView?.register(UINib(nibName: "WBStatusCellTableViewNormalCell", bundle: nil), forCellReuseIdentifier: originalCellId)
        tableView?.register(UINib(nibName: "WBStatusCellTableViewRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        // 设置行高
        //取消行高自动适应
        //tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        // 取消底部分割线
        tableView?.separatorStyle = .none
        
        setupNavTitle()
    }
    
    // 设置导航栏按钮
    func setupNavTitle(){
        
        let button = UIButton()
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.black, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle(WBNetworkManager.shared.userAccount.screen_name, for: .normal)
        
        button.setImage(UIImage(named:"down.png"), for: .normal)
        button.setImage(UIImage(named:"up.png"), for: .selected)
        button.sizeToFit()
        
        navItem.titleView = button
        
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    func clickTitleButton(btn : UIButton){
        //设置选中状态
        btn.isSelected = !btn.isSelected
    }
    
}
