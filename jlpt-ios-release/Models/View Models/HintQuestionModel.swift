//
//  HintQuestionModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/07.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct HintQuestionModel {
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let solution: String
    /// - If type of hint is listening. It will have link audio
    var linkAudio: String?

    /// - Initial code here
    init?(response: HintQuestion) {
        self.question = response.question
        self.answerA = response.answerA
        self.answerB = response.answerB
        self.answerC = response.answerC
        self.answerD = response.answerD
        self.solution = response.solution
        self.linkAudio = response.linkAudio
    }
}
