//
//  ListeningQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class ListeningQuestionController: UIViewController {

    @IBOutlet weak var questionLb: UILabel! {
        didSet {
            questionLb.text = """
            藤原竜也 × 伊藤英明
            😲すべての国民が、この男に狂わされる❗殺人告白本📚から事件が始まる新感覚サスペンス・アクション大作❗❗
            『22年目の告白－私が殺人犯です－』ブルーレイ&DVD好評発売中/デジタル好評配信中
            """
        }
    }

    @IBOutlet weak var answerALb: UILabel! {
        didSet {
            answerALb.text = """
                            藤原竜也 × 伊藤英明
                            😲すべての国民が、この男に狂わされる❗殺人告白本📚から事件が始まる新感覚サスペンス・アクション大作❗❗
                            『22年目の告白－私が殺人犯です－』ブルーレイ&DVD好評発売中/デジタル好評配信中
                            """
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
