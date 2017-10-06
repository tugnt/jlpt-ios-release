//
//  UIViewController+Storyboard.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/01.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIViewController {
    func initialViewController(controller: UIViewController) -> UIViewController {
        let sb = UIStoryboard(name: String(describing: controller.self), bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: controller.self))
        return vc
    }
}
