//
//  HidenKeyboardViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/12/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class HidenKeyboardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
