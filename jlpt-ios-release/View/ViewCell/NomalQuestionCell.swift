//
//  NomalQuestionCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/09.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

protocol NormalQuestionCellDelegate: class {
    func radioClicked(_ index: Int)
}

class NomalQuestionCell: UITableViewCell {
    var isShowSolution: Bool = false
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerALabel: UILabel!
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!
    @IBOutlet var arrayRadioButton: [TDRadioButton]!
    weak var delegate: NormalQuestionCellDelegate?
    var normalQuestion: NormalQuestionViewModel? {
        didSet {
            guard let question = normalQuestion else { return }
            questionLabel.text = question.question
            answerALabel.text = question.answerA
            answerBLabel.text = question.answerB
            answerCLabel.text = question.answerC
            answerDLabel.text = question.answerD
        }
    }

    @IBAction func radioClicked(_ sender: TDRadioButton) {
        for (index, button) in self.arrayRadioButton.enumerated() {
            if button == sender {
                button.isClicked = true
                delegate?.radioClicked(index)
            } else {
                button.isClicked = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
