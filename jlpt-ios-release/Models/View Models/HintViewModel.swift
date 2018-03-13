//
//  HintViewModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/06.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct HintViewModel {
    let hintTitle: String
    let hintContent: String
    let unit: String
    let numberQuestion: Int
    let point: Int
    let isPassed: Bool
    var questions: [HintQuestionModel] = []
    init(response: HintItemResponse) {
        self.hintTitle = response.title
        self.hintContent = response.content
        self.unit = response.unit
        for question in response.questions {
            questions.append(HintQuestionModel(response: question)!)
        }
        /// Todo: count number unit here
        self.numberQuestion = response.questions.count
        self.point = 0
        self.isPassed = false
    }
}
