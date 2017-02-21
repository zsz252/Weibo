//
//  UIImageView+WebImage.swift
//  Weibo
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import SDWebImage

extension UIImageView{
    
    /// 隔离 SDWebImage 设置图像函数
    ///
    /// - parameter urlString:        urlString
    /// - parameter placeholderImage: 占位图像
    /// - parameter isAvatar:         是否是头像
    func wb_setImage(urlString:String,placeholderImage:UIImage?,isAvatar:Bool = false){
        
        // 处理URL
        guard let url = URL(string: urlString) else{
            //设置占位图像
            image = placeholderImage
            
            return
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self] (image, _, _, _) in
            
            if isAvatar{
                self?.image = image?.wb_avatarImage(size: self?.bounds.size)
            }
        }
        
    }
}
