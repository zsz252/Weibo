//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by apple on 2017/1/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
import SDWebImage
class WBStatusListViewModel {
    
    //微博数据模型懒加载
    lazy var statusList = [WBStatusViewModel]()
    
    /// 加载微博列表
    ///
    /// - parameter pullup:     是否上拉刷新标记
    /// - parameter completion: 完成回调(网络请求是否成功，是否刷新表格)
    func loadStatus(pullup:Bool,completion: @escaping (_ isSucess:Bool)->()){
        
        // since_id 取出数组中第一条微博的id
        let since_id = pullup ? 0 : (self.statusList.first?.status.id ?? 0)
        // 上拉刷新，取出数组最后一条微博的id
        let max_id = pullup ? (self.statusList.last?.status.id) ?? 0 : 0
        
        WBNetworkManager.shared.statusList(since_id:since_id,max_id: max_id)  { (list, isSucess) in
            //判断网络请求是否成功
            if !isSucess{
                completion(false)
                
                return
            }
            
            // 定义结果可变数组
            var array = [WBStatusViewModel]()
            
            // 遍历服务器返回的字典数组，字典转模型
            for dict in list {
                
                // 创建微博模型
                let model = WBStatus.yy_model(with: dict)
                
                // 将 视图模型 添加到数组
                array.append(WBStatusViewModel(model: model!))
            }
            
            //拼接数据
            pullup ? (self.statusList += array) : (self.statusList = array + self.statusList)
            
            if pullup && array.count != 0{
                
                self.cacheSingleImage(list: array)
                //完成回调 网络请求是否成功
                completion(isSucess)
            }

        }
    }
    
    
    /// 缓存本子下载微博数据数组中的单张图像
    ///
    /// - parameter list: 本次下载的视图模型数组
    func cacheSingleImage(list:[WBStatusViewModel]){
        
        //调度组
        let group = DispatchGroup()
        
        var length = 0
        //遍历数组，查找微博数据中有单张图像的，进行缓存
        for vm in list{
            
            //1.判断图像数量
            if vm.picURLs?.count != 1{
                continue
            }
            
            //2.获取图像模型
            guard let pic = vm.picURLs![0].thumbnail_pic,
                let url = URL(string: pic) else{
                    continue
            }
            // 入组
            group.enter()
            
            //3.下载图像
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                
                let data = UIImagePNGRepresentation(image!)
                
                length += (data?.count)!
                
                //出组，放在闭包最后一句
                group.leave()
            })
        }
        
        // 监听调度组情况
        group.notify(queue: DispatchQueue.main) { 
            
        }
    }
}
