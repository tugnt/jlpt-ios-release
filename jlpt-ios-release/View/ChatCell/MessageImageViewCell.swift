//
//  MessageImageViewCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/17.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class MessageImageViewCell: UICollectionViewCell, ConfigurableCell {
    typealias DataType = MessageImageModel

    static var identifier: String { return String(describing: self) }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {

    }

    func configure(data: MessageImageModel) {

    }
}
