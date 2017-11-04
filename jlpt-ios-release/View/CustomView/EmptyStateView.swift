//
//  EmptyStateView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/29.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    fileprivate let emptyStateImage: UIImageView = UIImageView()
    fileprivate let messageLabel: UILabel = UILabel()

    init() {
        super.init(frame: .zero)
        addSubview(emptyStateImage)
        addSubview(messageLabel)
        let widthImage = 240
        let heightImage = 305
        emptyStateImage.snp.makeConstraints { make in
            make.width.equalTo(widthImage)
            make.height.equalTo(heightImage)
            make.center.equalToSuperview()
        }
        emptyStateImage.contentMode = .scaleAspectFit
        emptyStateImage.image = Asset.emptyStatePlaceholder.image

        messageLabel.snp.makeConstraints { make in
            make.left.right.equalTo(emptyStateImage)
            make.top.equalTo(emptyStateImage.snp.bottom).offset(20)
            make.centerX.equalTo(emptyStateImage)
        }
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        messageLabel.text = "Hiện tại chưa có dữ liệu về phần này. Chúng tôi sẽ cập nhật trong thời gian sớm nhất"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
