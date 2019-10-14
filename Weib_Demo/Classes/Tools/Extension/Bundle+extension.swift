//
//  Bundle+extension.swift
//  XtWeiBo
//
//  Created by 徐腾 on 2017/7/18.
//  Copyright © 2017年 徐腾. All rights reserved.
//

import Foundation

extension Bundle {
    
    var namespace : String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    
}
