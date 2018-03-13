//
//  UITextField+Login.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/18.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UITextField {
    func setUpLoginTextField() {
        layer.borderColor = ColorName.borderTextFieldColor.color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 3
    }
}

class LoginTextFeild: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLoginTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        settingLoginTextField()
    }

    private func settingLoginTextField() {
        layer.borderColor = ColorName.borderTextFieldColor.color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 3
    }
}
