//
//  Unit.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/23.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Himotoki

struct UnitRequest: JLPTRequest {
    typealias Response = UnitResponse
    var endPoint: String {
        return "/questions/\(level.rawValue)/\(type.rawValue)"
    }
    var method: HTTPMethod = .get
    let level: LevelJLPT
    let type: TypeJLPT
}

struct  UnitResponse: JLPTResponse {
    let units: [String]

    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> UnitResponse {
        return try UnitResponse(units: e <|| "units")
    }
}
