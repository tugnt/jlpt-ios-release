//
//  ListeningQuestionModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/07.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct ListeningQuestionModel {
    // Cái này không phải là hint question model mà phải là listening question model
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let solution: String
    /// - If type of hint is listening. It will have link audio
    var audioUrl: String?
    var imageUrl: String?

    init?(response: HintQuestion) {
        self.question = response.question
        self.answerA = response.answerA
        self.answerB = response.answerB
        self.answerC = response.answerC
        self.answerD = response.answerD
        self.solution = response.solution
        self.audioUrl = response.audioUrl
        self.imageUrl = response.imageUrl
    }
    
    init(normalResponse: QuestionResponse) {
        self.question = normalResponse.question
        self.answerA = normalResponse.answerA
        self.answerB = normalResponse.answerB
        self.answerC = normalResponse.answerC
        self.answerD = normalResponse.answerD
        self.solution = normalResponse.solution
        self.audioUrl = normalResponse.linkAudio
        self.imageUrl = normalResponse.imageUrl
    }
}
