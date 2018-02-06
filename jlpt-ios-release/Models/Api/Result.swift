//
//  Result.swift
//  jlpt-ios-release
//
//  Created by t_nguyen on 2017/09/22.
//  Copyright © 2017年 Nguyen Trong Tung. All rights reserved.
//

import Foundation

public protocol ResultType {
    associatedtype Value
    associatedtype Error: Swift.Error

    init(value: Value)
    init(error: Error)

    var value: Value? { get }

    var error: Error? { get }
}

public enum Result<Value, Error: Swift.Error>: ResultType {
    case success(Value)
    case failure(Error)

    public init(error: Error) {
        self = .failure(error)
    }

    public init(value: Value) {
        self = .success(value)
    }

    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
