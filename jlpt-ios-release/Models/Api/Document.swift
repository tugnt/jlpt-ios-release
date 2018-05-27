//
//  Document.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/01/14.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import Foundation
import Himotoki

struct DocumentRequest: JLPTRequest {
    typealias Response = JLPTDocumentResponse
    var endPoint: String { return "/documents/\(level)/\(type)" }
    let method: HTTPMethod = .get
    let type: String
    let level: Int
}

struct JLPTDocumentResponse: JLPTResponse {
    let documents: [DocumentReponse]
    static func decode(_ e: Extractor) throws -> JLPTDocumentResponse {
        return try JLPTDocumentResponse(documents: e <|| "documents")
    }
}

struct DocumentReponse: JLPTResponse {
    let enName: String
    let jpName: String
    let linkDocument: String
    let documentImage: String
    static func decode(_ e: Extractor) throws -> DocumentReponse {
        return try DocumentReponse(enName: e <| "en_name",
                                   jpName: e <| "jp_name",
                                   linkDocument: e <| "link_document",
                                   documentImage: e <| "document_image")
    }
}
