//
//  UIViewController+NavTitle.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/29.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIViewController {
    func setUpTitle(type: TypeJLPT?) -> String {
        guard let type = type else { return ""}
        var title: String = ""
        switch type {
        case .grammar:
            title = "ngữ pháp"
        case .kanji:
            title = "hán tự"
        case .listening:
            title = "nghe hiểu"
        case .reading:
            title = "đọc hiểu"
        case .vocabulary:
            title = "từ vựng"
        }
        return title
    }
}
