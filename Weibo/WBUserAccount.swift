//
//  WBUserAccount.swift
//  Weibo
//
//  Created by apple on 2017/2/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBUserAccount: NSObject {

    //访问令牌
    var access_token:String?
    //用户代号
    var uid:String?
    //过期日期（单位秒）
    var expires_in:TimeInterval = 0.0
    
    override var description: String{
        return yy_modelDescription()
    }
}
