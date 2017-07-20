//
//  WBComposeViewController.swift
//  Weibo
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

// 撰写微博控制器
class WBComposeViewController: UIViewController {

    // 文字编辑视图
    @IBOutlet weak var textView: UITextView!
    // 底部工具栏
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet var sendButton: UIButton!
    //标题标签
    @IBOutlet var titleLable: UILabel!
    
//    lazy var sendButton:UIButton = {
//        
//        let btn = UIButton()
//        
//        btn.setTitle("发布", for: .normal)
//        btn.setTitleColor(UIColor.orange, for: .normal)
//        btn.setTitleColor(UIColor.gray, for: .disabled)
//        btn.setTitleColor(UIColor.red, for: .highlighted)
//        
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        
//        btn.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
//        
//        return btn
//    }()
    @IBAction func pushStatus(_ sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func close(){
        dismiss(animated: true) { 
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension WBComposeViewController{
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        
        setupNavgationBar()
        setupToolBar()
    }
    
    func setupToolBar(){
        let itemSettings = [["imageName":"compose1"],
                            ["imageName":"compose2"],
                            ["imageName":"compose3"],
                            ["imageName":"compose4"],
                            ["imageName":"compose5"]]
        var items = [UIBarButtonItem]()
        
        for s in itemSettings{
            
            let imageName = s["imageName"]
            let image = UIImage(named: imageName!)
            
            let btn = UIButton()
            
            btn.sizeToFit()
            
            btn.setImage(image, for: .normal)
            
            items.append(UIBarButtonItem(customView: btn))
            
            //追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        
        //删除最后的弹簧
        items.removeLast()
        
        // 追加按钮
        toolBar.items = items
    }
    
    func setupNavgationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        navigationItem.titleView = titleLable
    }
}
