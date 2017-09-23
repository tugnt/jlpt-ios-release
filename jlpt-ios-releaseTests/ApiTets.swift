//
//  ApiTets.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/18.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import XCTest
@testable import jlpt-ios-release

class ApiTets: XCTestCase {

    func testExample() {
        let request = QuestionRequest(type: .grammar, level: .N5, unit: "1")
        ApiClient.instance.request(request: request, completion: { (result) in
            switch result {
            case .success(let value):
                XCTAssertNotNil(value)
            case .failure(let error):
                XCTFail()
            }
        })
    }
}
