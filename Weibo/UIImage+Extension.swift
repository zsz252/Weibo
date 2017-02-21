//
//  UIImage+Extension.swift
//  Weibo
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 图像圆角化
extension UIImage{
    
    func wb_avatarImage(size:CGSize?,backColor:UIColor = UIColor.white,lineColor:UIColor = UIColor.lightGray) -> UIImage? {
        
        var size = size
        if size == nil{
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(in: rect)
        
        let ovalPath = UIBezierPath(ovalIn: rect)
        ovalPath.lineWidth = 2
        lineColor.setStroke()
        ovalPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
    
        UIGraphicsEndImageContext()
        
        return result
    }
    
}
