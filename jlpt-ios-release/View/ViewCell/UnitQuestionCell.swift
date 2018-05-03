//
//  UnitQuestionCell.swift
//  TestCollectionView
//
//  Created by Alex K. on 12/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ExpandingCollection


class UnitQuestionCell: BasePageCollectionCell {
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var jlptTypeLabel: UILabel!
    @IBOutlet weak var detailQuestionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTitle.layer.shadowRadius = 2
        customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        customTitle.layer.shadowOpacity = 0.2
    }
}
