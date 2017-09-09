//
//  UIStoryboard+Identifier.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/09.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String{
        case home
        var name: String {
            switch self {
            case .home: return "Home"
            }
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name, bundle: bundle)
    }
}
