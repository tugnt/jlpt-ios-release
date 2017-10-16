//
//  CustomButton.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/24.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

@IBDesignable class CancelButton: UIButton {
    let background: UIColor = ColorName.cancelBtnBg.color
    let backgroundSelect: UIColor = ColorName.cancelBtnBgSelected.color
    let titleColor: UIColor = ColorName.cancelTitle.color
    let titleColorSelected: UIColor = ColorName.cancelTitleSelected.color
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
        self.backgroundColor = background
    }
}
