//
//  UIViewController+UIButton.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIButton {
    func setUpJLPTButton() {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(3)
        layer.backgroundColor = UIColor.red.cgColor
    }
}
