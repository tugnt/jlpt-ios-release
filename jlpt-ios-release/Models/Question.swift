//
//  Question.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/18.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Himotoki

struct QuestionRequest: JLPTRequest {
    typealias Response = JLPTQuestionResponse
    let method: HTTPMethod = .get
    var endPoint: String {
        return "/questions/\(level.rawValue)/\(type.rawValue)/\(unit)"
    }
    let type: TypeJLPT
    let level: LevelJLPT
    let unit: String
}

struct QuestionResponse: JLPTResponse {
    let unit: String
    let type: String
    let level: Int
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let solution: String
    var linkAudio: String?
    
    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> QuestionResponse {
        return try QuestionResponse(unit:       e <| "unit",
                                    type:       e <| "type",
                                    level:      e <| "level",
                                    question:   e <| "question",
                                    answerA:    e <| "answerA",
                                    answerB:    e <| "answerB",
                                    answerC:    e <| "answerC",
                                    answerD:    e <| "answerD",
                                    solution:   e <| "solution",
                                    linkAudio:  e <|? "linkAudio")
    }
}

struct JLPTQuestionResponse: JLPTResponse {
    let jlptQuestion : [QuestionResponse]
    
    static func decode(_ e: Extractor) throws -> JLPTQuestionResponse {
        return try JLPTQuestionResponse(jlptQuestion: e <|| "jlpt_question")
    }
}
