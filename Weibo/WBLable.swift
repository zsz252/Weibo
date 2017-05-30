//
//  WBLable.swift
//  Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareTextSystem()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置绘制区域
        textContainer.size = bounds.size
    }
    
    // 绘制文本
    override func drawText(in rect: CGRect) {
        
        let range = NSRange(location: 0, length: textStorage.length)
        
        layoutManager.drawBackground(forGlyphRange: range, at: CGPoint())
        
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
                [NSForegroundColorAttributeName:UIColor.red,
                    NSBackgroundColorAttributeName:UIColor.brown
                ], range: r!)
        }
    }
}

// MARK: - 正则表达式函数
extension WBLable{
    
    var urlRanges: [NSRange?]{
        
        // 1 正则表达式
        let pattern = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else{
            return []
        }
        
        let matchs = regx.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))
        
        var ranges = [NSRange]()
        
        for m in matchs{
            
            ranges.append(m.rangeAt(0))
            
        }
        
        return ranges
    }
    
}



