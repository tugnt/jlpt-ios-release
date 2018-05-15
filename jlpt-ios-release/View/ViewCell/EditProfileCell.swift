//
//  EditProfileCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class EditProfileCell: UITableViewCell {
    @IBOutlet weak var titleTypeSetting: UILabel!
    @IBOutlet weak var contentTypeSetting: UILabel!

    var editItem: EditProfileItem? {
        didSet {
            guard let item = editItem else { return }
            titleTypeSetting.text = item.titleProfile.rawValue
            contentTypeSetting.text = item.contentProfile
        }
    }
}
