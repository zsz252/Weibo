//
//  Bundle+Extensions.swift
//  Weibo
//
//  Created by apple on 2017/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

extension Bundle{
    
    var namespace:String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
