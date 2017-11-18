//
//  Validation.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/19.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

//
//  Validation.swift
//  RenosyInsight
//
//  Created by t_nguyen on 2017/09/19.
//  Copyright © 2017年 GA technologies Inc. All rights reserved.
//
import Foundation

enum RegexString: String {
    case emailRex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$"
    case emailPassRex = "^[a-zA-Z0-9.!#$%&‘*+/=?^_`{|}~-]{8,16}$"
}

class Validation {
    let expression: NSRegularExpression?
    let pattern: RegexString

    init(_ pattern: RegexString) {
        self.pattern = pattern
        do {
            self.expression = try NSRegularExpression(pattern: pattern.rawValue, options: .caseInsensitive)
        } catch {
            self.expression = nil
        }
    }

    func validateString(inputString: String) -> Bool {
        guard let expression = expression else {
            return false
        }
        let range = NSRange(location: 0, length: inputString.count)
        let matcher = expression.matches(in: inputString, options: [], range: range)
        return matcher.count > 0
    }
}
