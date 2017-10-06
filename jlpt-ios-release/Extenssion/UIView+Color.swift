//
//  UIView+Color.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/24.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIColor {
    func rbg(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}

class UtilsColor {
    static func lottie() -> UIColor {
        return UIColor(red: 0 / 255, green: 209 / 255, blue: 193 / 255, alpha: 1)
    }
}
