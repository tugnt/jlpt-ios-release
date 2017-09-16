//
//  UIStoryboard+Identifier.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String{
        case progress
        case profile
        
        var name: String {
            switch self {
            case .progress: return "Process"
            case .profile: return "Profile"
            }
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name, bundle: bundle)
    }
}
