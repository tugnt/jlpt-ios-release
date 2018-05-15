//
//  JLPTUnitCellCollectionViewCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/13.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import ExpandingCollection

class JLPTUnitCellCollectionViewCell: BasePageCollectionCell {
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    var levelJLPT: LevelJLPT?
    @IBOutlet weak var unitLabel: UILabel!

    var unit: String? {
        didSet {
            guard let unit = unit else { return }
            unitLabel.text = "Đề số\n \(unit)"
        }
    }
}
