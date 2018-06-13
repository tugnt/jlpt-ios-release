//
//  UIViewController+Admob.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/05/17.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import Foundation

extension UIViewController {
    func earnCoins() {
        Setting.coins = Setting.coins + 5
    }
    
    func reductionCoins() {
        if Setting.coins > 0 {
            Setting.coins -= 1
        }
    }
}
