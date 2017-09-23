//
//  RequestError.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/17.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

public enum RequestError: Error {
    case HTTPError(NSError)
    case DecodeError(Error)
    case InvalidError
}
