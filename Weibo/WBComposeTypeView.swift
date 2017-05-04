//
//  WBComposeTypeView.swift
//  Weibo
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBComposeTypeView: UIView {

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

}
