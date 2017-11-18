//
//  MessageTextViewCell.swift
//  RenosyInsight
//
//  Created by t_nguyen on 2017/11/14.
//  Copyright © 2017年 GA technologies Inc. All rights reserved.
//
import UIKit

class MessageTextViewCell: UICollectionViewCell, ConfigurableCell {
    typealias DataType = MessageTextModel
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
        timeView.isHidden = true
    }

    func configure(data: MessageTextModel) {
        // Todo: Update UI
        updateUI(data: data)
        // Todo: Configure data
    }

    func updateUI(data: MessageTextModel) {
        data.senderId.isEmpty ? updateLeftMessageView(data: data) : updateRightMessageView(data: data)
        messageLabel.text = data.message
    }

    func updateLeftMessageView(data: MessageTextModel) {
        profileImage.isHidden = false
        bubbleImageView.image = MessageTextViewCell.grayBubble
        bubbleImageView.tintColor = UIColor(white: 0.9, alpha: 1)
        messageLabel.textColor = .black
        let estimatedFrame = estimatedTextFrame(textMessage: data.message)
        containerTextView.frame = CGRect(x: 40, y: 0, width: estimatedFrame.width + 40, height: estimatedFrame.height + 20)
        messageLabel.frame = CGRect(x: 20, y: 0, width: estimatedFrame.width + 10, height: estimatedFrame.height + 20)
        // Todo: Show or hiden timeView
    }

    func updateRightMessageView(data: MessageTextModel) {
        let estimatedFrame = estimatedTextFrame(textMessage: data.message)
        messageLabel.frame = CGRect(x: 20, y: 0, width: estimatedFrame.width + 10, height: estimatedFrame.height + 20)
        containerTextView.frame = CGRect(x: UIScreen.main.bounds.width - estimatedFrame.width - 40, y: 0, width: estimatedFrame.width + 40, height: estimatedFrame.height + 20)
        profileImage.isHidden = true
        bubbleImageView.image = MessageTextViewCell.blueBubble
        bubbleImageView.tintColor = .blue
        messageLabel.textColor = .white
    }

    func estimatedTextFrame(textMessage: String) -> CGRect {
        let textMssWidth = UIScreen.main.bounds.width * 2 / 3
        // Max height of mess text frame = 1000
        let messageSize = CGSize(width: textMssWidth, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimateTextFrame = NSString(string: textMessage).boundingRect(with: messageSize, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], context: nil)
        return estimateTextFrame
    }
}
