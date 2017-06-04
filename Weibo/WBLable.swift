//
//  WBLable.swift
//  Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

@objc protocol WBLableDelegate {
    @objc optional func lableDidSelectedLinkText(lable:WBLable,text:String)
}
class WBLable: UILabel {
    
    override var text: String?{
        didSet{
            prepareTextContent()
            
            setNeedsDisplay()
        }
    }

    override var attributedText: NSAttributedString?{
        didSet{
            prepareTextContent()
            print(attributedText?.string)
            
            setNeedsDisplay()
        }
    }
    
    var delegate:WBLableDelegate?
    
    /// 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareTextSystem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareTextSystem()
    }
    

    
    /// 用户交互
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 获取点击的位置
        guard let location = touches.first?.location(in: self) else{
            return
        }
        
        // 获取位置在文本中的idx
        let idx = layoutManager.glyphIndex(for: location, in: textContainer)
        
        // 判断是否在url中
        for r in urlRanges {
            
            if NSLocationInRange(idx, r!){
                
                textStorage.addAttributes([NSForegroundColorAttributeName:UIColor.red], range: r!)
                // 需要重绘调用函数
                setNeedsDisplay()
                
                delegate?.lableDidSelectedLinkText?(lable: self, text: self.textStorage.string)
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置绘制区域
        textContainer.size = bounds.size
        
        //lineBreakMode = .byTruncatingTail
    }
    
    // 绘制文本
    override func drawText(in rect: CGRect) {
        
        let range = NSRange(location: 0, length: textStorage.length)
        
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint())

    }
    
    /// TextKit 的 核心对象
    /// 属性文本储存
    lazy var textStorage = NSTextStorage()
    /// 负责文本‘文字’布局
    lazy var layoutManager = NSLayoutManager()
    /// 设置文本绘制的范围
    lazy var textContainer = NSTextContainer()

}

// MARK: - 设置 TextKit 的核心对象
extension WBLable{
    
    /// 准备文本系统
    func prepareTextSystem(){
        
        // 0 开启用户交互
        isUserInteractionEnabled = true
        
        // 1 准备文本内容
        prepareTextContent()
        
        // 2 设置对象关系
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    }
    
    /// 准备文本内容 - 是TextStorage接管Lable
    func prepareTextContent(){
        
        if let attributedText = attributedText{
            textStorage.setAttributedString(attributedText)
        }else if let text = text{
            textStorage.setAttributedString(NSAttributedString(string: text))
        }else{
            textStorage.setAttributedString(NSAttributedString(string: ""))
        }
        
        for r in urlRanges{
            
            textStorage.addAttributes(
                [NSForegroundColorAttributeName:UIColor.blue], range: r!)
        }
    }
}

// MARK: - 正则表达式函数
extension WBLable{
    
    var urlRanges: [NSRange?]{
        
        // 1 正则表达式
        let patterns = ["[a-zA-Z]*://[a-zA-Z0-9/\\.]*","#.*?#","@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"]
        
        var ranges = [NSRange]()
        
        for pattern in patterns{
            guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else{
                return []
            }
        
            let matchs = regx.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))
        
            for m in matchs{
            
                ranges.append(m.rangeAt(0))
            
            }
        }
        
        return ranges
    }
    
}



