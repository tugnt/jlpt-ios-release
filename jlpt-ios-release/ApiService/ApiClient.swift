//
//  ApiClient.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/17.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Alamofire
import Himotoki

class ApiClient {
    static var instance = ApiClient()

    func request<Request: JLPTRequest> (request: Request, completion: @escaping  ((Result<Request.Response, RequestError>) -> Void)) {

        Alamofire.request(request.url,
                          method: request.method,
                          parameters: request.parameter,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseString(completionHandler: { (_) in })
            .responseJSON(completionHandler: { (responseJSON) in
                switch responseJSON.result {
                case .success(let response):
                    do {
                        let model = try Request.Response.decodeValue(response)
                        completion(Result(value: model))
                    } catch let DecodeError.missingKeyPath(keyPath) {
                        // catch error here
                        let msgError = "Miss \(keyPath.components) in response"
                        print(msgError)
                    } catch let DecodeError.typeMismatch(expected: expected, actual: actual, keyPath: keyPath) {
                        let msgError = "description: Failed to convert JSON value to model's property."
                            + "             Key path \(keyPath.components) expected `\(expected)` but was `\(actual)`."
                            + "key        : \(keyPath.components)"
                            + "expected   : \(expected)"
                            + "actual     : \(actual)"
                        print(msgError)
                        //completion(Result(error: .decodeError(DecodeError.typeMismatch(expected: expected, actual: actual, keyPath: keyPath))))
                    } catch {
                        // Todo: Handle Error here
                    }
                case .failure(let error):
                    //completion(Result(error: error))
                    print(error)
                }
            })
    }
}
