//
//  WBComposeTypeView.swift
//  Weibo
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import pop

class WBComposeTypeView: UIView {

    let buttonInfo = [
        ["imageName":"error_48px_1201052_easyicon.net","title":"文字","clsName":"WBComposeViewController"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"照片/视频"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"长微博"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"签到"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"点评"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"更多","actionName":"clickMore"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"好友圈"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"微博相机"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"音乐"],
        ["imageName":"error_48px_1201052_easyicon.net","title":"拍摄"]
    ]
    
    // 完成回调
    var completionBlock: ((_ clsName:String?) -> ())?
    
    @IBOutlet weak var scrollView: UIScrollView!
    // 返回按钮X约束
    @IBOutlet weak var returnButtonCenterX: NSLayoutConstraint!
    // 退出按钮X约束
    @IBOutlet weak var closeButtonCenterX: NSLayoutConstraint!
    // 返回按钮
    @IBOutlet weak var returnButton: UIButton!
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
    func show(completion: @escaping (_ clsName:String?) -> ()){
        
        completionBlock = completion
        
        // 将当前视图添加到 根视图控制器
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        // 添加视图
        vc.view.addSubview(self)
        
        //开始动画
        showCurrentView()
    }
    
    func click(){
        
    }
    
    //点击更多按钮
    func clickMore(){
        
        self.isUserInteractionEnabled = false
        
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)
        
        returnButton.isHidden = false
        
        let margin = scrollView.bounds.width / 7
        returnButtonCenterX.constant -= margin
        closeButtonCenterX.constant += margin
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.layoutIfNeeded()
            }) { (_) in
                self.isUserInteractionEnabled = true
        }
        
    }
    
    //点击返回按钮
    @IBAction func clickReturn(_ sender: AnyObject) {
        
        self.isUserInteractionEnabled = false
        
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        
        let margin = scrollView.bounds.width / 7
        returnButtonCenterX.constant += margin
        closeButtonCenterX.constant -= margin
        
        UIView.animate(withDuration: 0.5, animations: { 
            
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
            
            }) { (_) in
                self.returnButton.alpha = 1
                self.returnButton.isHidden = true
                
                self.isUserInteractionEnabled = true
        }
        
    }
    
    // 关闭
    @IBAction func close() {
        //self.removeFromSuperview()
        hideButtons()
    }
    
    // 点击按钮
    func clickButton(selectedButton: WBComposeTypeButton){
        
        // 判断当前显示的视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        // 选择的按钮放大 其余的缩小
        for (i,btn) in v.subviews.enumerated(){
            
            // 缩放动画
            let scaleAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            
            let scale = (selectedButton == btn) ? 2 : 0.5
            
            scaleAnim?.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            scaleAnim?.duration = 0.3
            
            btn.pop_add(scaleAnim, forKey: nil)
            
            // 渐变动画
            let alphaAnim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            
            alphaAnim.fromValue = 0.2
            alphaAnim.toValue = 0.5
            btn.pop_add(alphaAnim, forKey: nil)
            
            // 添加动画监听
            if i == 0 {
                alphaAnim.completionBlock = { (_,_) in
                    
                    //完成回调
                    self.completionBlock?(selectedButton.clsName)
                }
            }
        }
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
        let width = scrollView.bounds.width
        
        for i in 0...1{
            
            let v = UIView(frame:rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            // 向 scrollview 添加视图
            addButtons(v: v, idx: i * 6)
        
            scrollView.addSubview(v)
        }
        //设置scrollview
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        
        // 禁用滚动
        scrollView.isScrollEnabled = false
    }
    
    
    /// 向视图中添加按钮，数组索引从idx开始
    func addButtons(v:UIView , idx:Int){
        
        let count = 6
        // 从 idx 开始添加6个按钮
        for i in idx..<(idx + count){
            
            if i >= buttonInfo.count{
                break
            }
            
            let btn = WBComposeTypeButton.composeTypeButton(imageName: buttonInfo[i]["imageName"]!, lable: buttonInfo[i]["title"]!)
            
            v.addSubview(btn)

            //添加监听方法
            if let actionName = buttonInfo[i]["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }else{
                btn.addTarget(self, action: #selector(clickButton(selectedButton:)), for: .touchUpInside)
            }
            
            // 设置类名
            btn.clsName = buttonInfo[i]["clsName"]
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

// MARK: - 动画方法扩展
extension WBComposeTypeView{
    
    //MARK: - 显示部分的动画
    //动画显示当前视图
    func showCurrentView(){
        //创建动画
        let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim?.fromValue = 0
        anim?.toValue = 1
        anim?.duration = 0.25
        
        //添加到视图
        pop_add(anim, forKey: nil)
        
        //添加按钮动画
        showButtons()
    }
    
    //弹力显示所有按钮
    func showButtons(){
        
        // 获取 scrollview 的子视图的第0个视图
        let v = scrollView.subviews[0]
        
        // 遍历所有按钮
        for (i,btn) in v.subviews.enumerated(){
            
            //创建动画
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            //设置动画属性
            anim?.fromValue = btn.center.y + 300
            anim?.toValue = btn.center.y
            
            //弹力系数 0~12 默认4
            anim?.springBounciness = 10
            //弹力速度 0~20 默认12
            anim?.springSpeed = 3
            
            //设置动画启动时间
            anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            //添加动画
            btn.pop_add(anim, forKey: nil)
        }
        
    }
    
    //MARK - :隐藏部分的动画
    func hideButtons(){
        
        //根据contenoffset 判断当前显示的子视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        let v = scrollView.subviews[page]
        
        for (i,btn) in v.subviews.enumerated(){
            
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            anim?.fromValue = btn.center.y
            anim?.toValue = btn.center.y + 350
            
            // 设置时间
            anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            anim?.springSpeed = 3
            //anim?.springBounciness = 6
            
            btn.layer.pop_add(anim, forKey: nil)
            
            // 监听第 0 个按钮的动画 ，是最后一个执行的
            if i==0 {
                anim?.completionBlock = { (_,_) in
                    
                    self.hideCurrentView()
                }
            }
        }
        
    }
    
    
    /// 隐藏当前视图
    func hideCurrentView(){
        
        let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        pop_add(anim, forKey: nil)
        
        anim.completionBlock = { (_,_) in
            self.removeFromSuperview()
        }
    }
}
