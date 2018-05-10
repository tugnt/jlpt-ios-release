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
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var detailQuestionButton: UIButton!
    @IBOutlet weak var jlptTypeLabel: UILabel!
    var detaillButtonDidSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        unitLabel.layer.shadowRadius = 2
        unitLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        unitLabel.layer.shadowOpacity = 0.2
        self.frontContainerView.backgroundColor = #colorLiteral(red: 0.1570000052, green: 0.5839999914, blue: 1, alpha: 1)
        detailQuestionButton.clipsToBounds = true
        let connerRadius = detailQuestionButton.bounds.height / 2
        detailQuestionButton.layer.cornerRadius = connerRadius
        detailQuestionButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
    }
    
    @objc private func sendAction() {
        self.detaillButtonDidSelected?()
    }
}
