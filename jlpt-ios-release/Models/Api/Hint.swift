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
    let hints: [HintItemResponse]
    static func decode(_ e: Extractor) throws -> JLPTHintResponse {
        return try JLPTHintResponse(hints: e <|| "tips")
    }
}

struct HintItemResponse: JLPTResponse {
    let title: String
    let type: TypeJLPT
    let unit: String
    let content: String
    let questions: [HintQuestion]

    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> HintItemResponse {
        guard let jlptType: String = try? e <| "type", let type = TypeJLPT(rawValue: jlptType) else { fatalError("Can decode jlpt type") }
        return try HintItemResponse(title: e <| "title",
                                    type: type,
                                    unit: e <| "unit",
                                    content: e <| "content",
                                    questions: e <|| "question")
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
    var imageUrl: String?
    var audioUrl: String?
    /// - Throws: DecodeError or an arbitrary ErrorType
    static func decode(_ e: Extractor) throws -> HintQuestion {
        return try HintQuestion(question: e <| "question",
                                answerA: e <| "answerA",
                                answerB: e <| "answerB",
                                answerC: e <| "answerC",
                                answerD: e <| "answerD",
                                solution: e <| "solution",
                                imageUrl: e <|? "image_url",
                                audioUrl: e <|? "audio_url")
    }
}
