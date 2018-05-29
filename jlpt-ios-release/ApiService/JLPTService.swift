//
//  JLPTService.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/17.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Alamofire

typealias HTTPMethod = Alamofire.HTTPMethod
typealias ParameterEncoding = Alamofire.ParameterEncoding
typealias Parameters = Alamofire.Parameters
typealias HTTPHeaders = Alamofire.HTTPHeaders
typealias JSONEncoding = Alamofire.JSONEncoding
typealias URLEncoding = Alamofire.URLEncoding

enum URLPath: String {
    case base = "http://li588-160.members.linode.com:3000/api"
}

protocol JLPTService {
    associatedtype Response: JLPTResponse
    var endPoint: String { get }
    var parameter: Parameters? { get }
    var method: HTTPMethod { get }
    var url: URL { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension JLPTService {
    var parameter: Parameters? { return nil }

    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding()
        default:
            return JSONEncoding()
        }
    }
}

protocol JLPTRequest: JLPTService { }

extension JLPTRequest {
    var url: URL {
        return URL(string: URLPath.base.rawValue + endPoint)!
    }
}
