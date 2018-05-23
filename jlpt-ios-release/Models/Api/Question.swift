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
    let unit: Int
}

struct AudioResponseModel: JLPTResponse {
    let audioUrl: String
    let imageUrl: String?
    static func decode(_ e: Extractor) throws -> AudioResponseModel {
        return try AudioResponseModel(audioUrl: e <| "audio_url",
                                      imageUrl: "image_url")
    }
}

struct QuestionResponse: JLPTResponse {
    let unit: Int
    let type: TypeJLPT
    let level: Int
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let solution: String
    let linkAudio: String?
    let imageUrl: String?
    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> QuestionResponse {
        guard let jlptType: String = try? e <| "type", let type = TypeJLPT(rawValue: jlptType) else { fatalError("Can decode jlpt type") }
        return try QuestionResponse(unit: e <| "unit",
                                    type: type,
                                    level: e <| "level",
                                    question: e <| "question",
                                    answerA: e <| "answerA",
                                    answerB: e <| "answerB",
                                    answerC: e <| "answerC",
                                    answerD: e <| "answerD",
                                    solution: e <| "solution",
                                    linkAudio: e <|? "linkAudio",
                                    imageUrl: e <|? "imageUrl")
    }
}

struct JLPTQuestionResponse: JLPTResponse {
    let jlptQuestion: [QuestionResponse]

    static func decode(_ e: Extractor) throws -> JLPTQuestionResponse {
        return try JLPTQuestionResponse(jlptQuestion: e <|| "jlpt_question")
    }
}
