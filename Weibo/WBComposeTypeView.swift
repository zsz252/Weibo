//
//  WBComposeTypeView.swift
//  Weibo
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        
//        self.backgroundColor = UIColor.blue
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    class func composeTypeView() -> WBComposeTypeView {
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView
        
        // xib 加载 默认是 600*600
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
    }
    
    // 显示当前视图
    func show(){
        
        // 将当前视图添加到 根视图控制器
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        // 添加视图
        vc.view.addSubview(self)
    }
    
    func click(){
        
    }
    
    // 关闭
    @IBAction func close() {
        self.removeFromSuperview()
    }
}


extension WBComposeTypeView{
    
    func setupUI(){
//        let btn = WBComposeTypeButton.composeTypeButton(imageName: "A295750F-90EA-47A4-8333-34A6A2655C69", lable: "书写")
//        
//        addSubview(btn)
//        
//        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        // 强行更新布局
        layoutIfNeeded()
        
        let rect = scrollView.bounds
        
        let v = UIView(frame:rect)
        // 向 scrollview 添加视图
        addButtons(v: v, idx: 0)
        
        scrollView.addSubview(v)
    }
    
    
    /// 向视图中添加按钮，数组索引从idx开始
    func addButtons(v:UIView , idx:Int){
        
        let count = 6
        // 从 idx 开始添加6个按钮
        for i in idx..<(idx + count){
            
            let btn = WBComposeTypeButton.composeTypeButton(imageName: "error_48px_1201052_easyicon.net", lable: "文字")
            
            v.addSubview(btn)
            
        }
        
        // 遍历视图的子视图，布局按钮
        let btnSize = CGSize(width: 100, height: 80)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for (i,btn) in v.subviews.enumerated(){
            
            //let y = (Int)(i / 3) * 120
            let y:CGFloat = (i>2) ? (v.bounds.height - btnSize.height) : 0
            
            let x = margin * CGFloat(i%3 + 1) + btnSize.width * CGFloat(i%3)
            
            btn.frame = CGRect(x: x, y: CGFloat(y), width: btnSize.width, height: btnSize.height)
            
            //print("\(i)  \(x)  \(y)")
        }
    }
}
