//
//  UIViewController+EmptyState.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/29.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIViewController {
    func addEmptyStateView() {
        let emptyStateView = EmptyStateView()
        view.addSubview(emptyStateView)
        emptyStateView.frame = view.frame
    }
}
