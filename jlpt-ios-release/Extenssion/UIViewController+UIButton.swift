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

    func setUpPrimaryButton() {
        clipsToBounds = true
        layer.cornerRadius = 3
        backgroundColor = ColorName.navBackground.color
        setTitleColor(.white, for: .normal)
        setTitleColor(ColorName.cancelBtnBg.color, for: .selected)
        addTarget(self, action: #selector(didTouchDismiss), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(didTouchUpDismiss), for: [.touchDragExit, .touchUpInside, .touchUpOutside])
    }

    func setUpDangerButton() {
        clipsToBounds = true
        layer.cornerRadius = 3
        backgroundColor = ColorName.cancelBtnBg.color
        addTarget(self, action: #selector(didTouchDismiss), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(didTouchUpDismiss), for: [.touchDragExit, .touchUpInside, .touchUpOutside])
    }

    @objc func didTouchDismiss() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.5
        }
    }

    @objc func didTouchUpDismiss() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1
        }
    }
}
