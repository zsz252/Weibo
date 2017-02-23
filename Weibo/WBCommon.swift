//
//  WBCommon.swift
//  Weibo
//
//  Created by apple on 2017/1/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
import UIKit
//MARK : - 应用程序信息
// 应用程序 ID
let WBAppKey = "2387325358"
// 应用程序加密信息(开发者可修改)
let WBAppSecret = "65fa9ddd49e055d986e1b3de794faa7a"
// 回调地址
let WBRedirectURL = "http://baidu.com"

//MARK : - 微博全局通知定义
//用户需要通知类型
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
//用户登录成功通知
let WBUserLoginSuccessedNotification = "WBUserLoginSuccessedNotification"

// MARK: - 微博配图视图常量
// 计算配图视图的宽度
let WBStatusPictureViewOutterMargin = CGFloat(12)
// 配图视图内部图像的间距
let WBStatusPictureViewInnerMargin = CGFloat(3)
// 屏幕的宽度
let WBStatusPictureViewWidth = UIScreen.main.bounds.size.width - 2 * WBStatusPictureViewInnerMargin
// 计算宽度
let WBStatusPictureItemWidth = (WBStatusPictureViewWidth - 2 * WBStatusPictureViewInnerMargin) / 3
