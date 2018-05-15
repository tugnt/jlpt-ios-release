//
//  HintCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/04.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class HintCell: UITableViewCell {
    @IBOutlet weak var hintTitleLabel: UILabel!
    @IBOutlet weak var hintDescriptionLabel: UILabel!
    @IBOutlet weak var hintNumberQuestionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var pinButton: UIButton! {
        didSet {
            pinButton.setImage(UIImage.fontAwesomeIcon(name: .tags, textColor: .lightGray, size: CGSize(width: pinButton.bounds.width, height: pinButton.bounds.height)), for: .normal)
        }
    }

    var hintItem: HintViewModel? {
        didSet {
            guard let item = hintItem else { return }
            hintTitleLabel.text = item.hintTitle
            hintDescriptionLabel.text = item.hintContent
            hintNumberQuestionLabel.text = "Số câu hỏi \(item.numberQuestion)"
        }
    }
}
