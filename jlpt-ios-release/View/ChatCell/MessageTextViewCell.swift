//
//  MessageTextViewCell.swift
//  RenosyInsight
//
//  Created by t_nguyen on 2017/11/14.
//  Copyright © 2017年 GA technologies Inc. All rights reserved.
//
import UIKit

class MessageTextViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    var timeView: MessageTimeView = MessageTimeView()
    lazy var messageLabel: UILabel = {
        return UILabel()
    }()

    lazy var containerTextView: UIView = {
        return UIView()
    }()
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()

    static let grayBubble: UIImage = Asset.bubbleGray.image.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubble: UIImage = Asset.bubbleBlue.image.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    let bubbleImageView: UIImageView = {
        let image = UIImageView()
        image.image = MessageTextViewCell.grayBubble
        image.tintColor = UIColor(white: 0.9, alpha: 1)
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        addSubview(containerTextView)
        containerTextView.layer.cornerRadius = 15
        containerTextView.layer.masksToBounds = true

        addSubview(profileImage)
        profileImage.image = Asset.circleN1.image
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.bottom.equalTo(containerTextView.snp.bottom)
            make.leading.equalToSuperview().offset(5)
        }

        containerTextView.addSubview(bubbleImageView)
        bubbleImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }

        bubbleImageView.addSubview(messageLabel)
        messageLabel.numberOfLines = 0

        addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.bottom.equalTo(containerTextView.snp.top)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
    }
}
