//
//  NomalQuestionCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/09.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class NomalQuestionCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            questionLabel.text = "なお、本作のメガホンをとったのは、前作『#ブレードランナー』を監督したリドリー・スコットの息子ルーク・スコット。35年の時を超え、奇跡の親子共演が実現しました"
        }
    }
    @IBOutlet weak var answerALabel: UILabel! {
        didSet {
            answerALabel.text = "なお、本作のメガホンをとったのは、前作『#ブレードランナー』を監督したリドリー・スコットの息子ルーク・スコット。35年の時を超え、奇跡の親子共演が実現しました"
        }
    }
    @IBOutlet weak var answerBLabel: UILabel!
    @IBOutlet weak var answerCLabel: UILabel!
    @IBOutlet weak var answerDLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
