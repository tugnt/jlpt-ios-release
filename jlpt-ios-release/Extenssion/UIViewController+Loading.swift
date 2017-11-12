//
//  UIViewController+Loadding.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/12.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIViewController {
    func startAnimationLoading() {
        let indicator = TDIndicator(frame: view.bounds)
        indicator.tag = 101
        view.addSubview(indicator)
    }

    func stopAnimationLoading() {
        guard let viewIndicatorWithTag = view.viewWithTag(101)  as? TDIndicator else { return }
        viewIndicatorWithTag.stopIndicatorLoading()
    }
}
