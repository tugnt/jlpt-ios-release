//
//  GroupChatViewCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/19.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class GroupChatViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var groupImageView: UIView!
    @IBOutlet weak var leftImage: UIView!
    @IBOutlet weak var rightTopImage: UIView!
    @IBOutlet weak var rightBottomImage: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupImageView.layer.cornerRadius = 30
        groupImageView.clipsToBounds = true
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 3
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 3)
        layer.shadowPath = shadowPath.cgPath
    }

}
