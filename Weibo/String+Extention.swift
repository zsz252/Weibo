//
//  String+Extention.swift
//  Weibo
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

extension String{
    
    // 从当前字符串中提取链接和文博
    func wb_href() -> () {
        
        // 匹配方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // 创建正则表达式
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),
            let reslut = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count))
        else {
            return
        }
        
        // 获取结果
        let link = (self as? NSString)?.substring(with: reslut.rangeAt(1))
        let text = (self as? NSString)?.substring(with: reslut.rangeAt(2))
    }
}
