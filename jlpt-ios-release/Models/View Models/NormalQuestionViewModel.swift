//
//  NormalQuestionViewModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct NormalQuestionViewModel {
    let question: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let solution: String
    /// - If type of hint is listening. It will have link audio
    var linkAudio: String?
}
