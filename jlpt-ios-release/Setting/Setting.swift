//
//  Setting.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2018/05/12.
//  Copyright © 2018年 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct Setting {
    static var firstRunApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "firstRunApp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstRunApp")
            UserDefaults.standard.synchronize()
        }
    }
}
