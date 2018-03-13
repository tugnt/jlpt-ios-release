//
//  JLPTUnitCellCollectionViewCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/13.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class JLPTUnitCellCollectionViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
//    @IBOutlet weak var circleImage: UIImageView!
    var levelJLPT: LevelJLPT? {
        didSet {
//            guard let level = levelJLPT else { return }
//            switch level {
//            case .n1:
//                circleImage.image = Asset.circleN1.image
//            case .n2:
//                circleImage.image = Asset.circleN2.image
//            case .n3:
//                circleImage.image = Asset.circleN3.image
//            case .n4:
//                circleImage.image = Asset.circleN4.image
//            case .n5:
//                circleImage.image = Asset.circleN5.image
//            }
        }
    }
    @IBOutlet weak var unitLabel: UILabel!

    var unit: String? {
        didSet {
            guard let unit = unit else { return }
            unitLabel.text = "Đề số\n \(unit)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
