//
//  NomalQuestionCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/09.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

protocol NormalQuestionCellDelegate: class {
    func radioClicked(_ indexButton: Int, didSelected cell: NomalQuestionCell)
}

class NomalQuestionCell: UITableViewCell {
    var solution: String = ""
    var isShowSolution: Bool = false {
        didSet {
            solutionLabelHeightConstraints.constant = isShowSolution == true ? 16 : 0
            self.layoutIfNeeded()
        }
    }
    @IBOutlet weak var solutionLabelHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var solutionLabel: UILabel!
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
            switch question.solution {
            case "0":
                solution = "A"
            case "1":
                solution = "B"
            case "2":
                solution = "C"
            case "3":
                solution = "D"
            default:
                break
            }
            solutionLabel.text = "Đáp án \(solution)"
        }
    }

    @IBAction func radioClicked(_ sender: TDRadioButton) {
        for (index, button) in self.arrayRadioButton.enumerated() {
            if button == sender {
                button.isClicked = true
                delegate?.radioClicked(index, didSelected: self)
            } else {
                button.isClicked = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
