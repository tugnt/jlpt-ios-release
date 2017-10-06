//
//  Tips.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/23.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Himotoki

struct HintRequest: JLPTRequest {
    typealias Response = JLPTHintResponse
    var endPoint: String {
        return "/tips/\(type.rawValue)"
    }
    let method: HTTPMethod = .get
    let type: TypeJLPT
}

struct JLPTHintResponse: JLPTResponse {
    let title: String
    let type: String
    let unit: String
    let content: String
    let questions: [HintQuestion]
    
    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> JLPTHintResponse {
        return try JLPTHintResponse(title:       e <| "title",
                                    type:        e <| "type",
                                    unit:        e <| "unit",
                                    content:     e <| "content",
                                    questions:   e <|| "question")
    }
}


/// - May using for hint view model
struct HintQuestion: JLPTResponse {
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let solution: String
    var linkAudio: String?
    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> HintQuestion {
        return try HintQuestion(question:   e <| "question",
                                answerA:    e <| "answerA",
                                answerB:    e <| "answerB",
                                answerC:    e <| "answerC",
                                answerD:    e <| "answerD",
                                solution:   e <| "solution",
                                linkAudio:  e <|? "linkAudio")
    }
}

