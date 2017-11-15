//
//  ChatRoomController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class ChatRoomController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let tmpData: [Message] = SampleMessageData.messages
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat room"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageTextViewCell.self, forCellWithReuseIdentifier: MessageTextViewCell.identifier)
        setCollectionViewLayout()
    }

    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
    }
}

extension ChatRoomController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tmpData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageTextViewCell.identifier, for: indexPath) as? MessageTextViewCell else {
            return UICollectionViewCell()
        }
        cell.messageLabel.text = tmpData[indexPath.row].message
        let sender = tmpData[indexPath.row].isSender
        if sender {
            // Show right side
            updateRightMessage(index: indexPath.row, cell: cell)
        } else {
            // Show left side
            updateLeftMessage(index: indexPath.row, cell: cell)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // - Estimate cell height and width
        let estimatedFrame = estimatedTextFrame(textMessage: tmpData[indexPath.row].message)
        let estimatedTimeViewHeight: CGFloat = ((indexPath.row - 1 >= 0) &&
            (tmpData[indexPath.row - 1].isSender) == tmpData[indexPath.row].isSender) ? 0 : 20
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20 + estimatedTimeViewHeight)
    }
}

extension ChatRoomController {
    func estimatedTextFrame(textMessage: String) -> CGRect {
        let textMssWidth = UIScreen.main.bounds.width * 2 / 3
        // Max height of mess text frame = 1000
        let messageSize = CGSize(width: textMssWidth, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimateTextFrame = NSString(string: textMessage).boundingRect(with: messageSize, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], context: nil)
        return estimateTextFrame
    }

    func updateLeftMessage(index: Int, cell: MessageTextViewCell) {
        cell.profileImage.isHidden = false
        let estimatedFrame = estimatedTextFrame(textMessage: tmpData[index].message)
        let heightTimeView = getHeightTimeView(index: index, cell: cell)
        cell.messageLabel.frame = CGRect(x: 20, y: 0, width: estimatedFrame.width + 10, height: estimatedFrame.height + 20)
        cell.containerTextView.frame = CGRect(x: 40, y: heightTimeView, width: estimatedFrame.width + 40, height: estimatedFrame.height + 20)
        // If mutiple mess has same side will hidden profile image
        if (index + 1 < tmpData.count) && (tmpData[index].isSender == tmpData[index + 1].isSender) {
            // TODO: Will be not show bubble with tails
            cell.profileImage.isHidden = true
        }
    }

    func updateRightMessage(index: Int, cell: MessageTextViewCell) {
        let estimatedFrame = estimatedTextFrame(textMessage: tmpData[index].message)
        let heightTimeView = getHeightTimeView(index: index, cell: cell)
        cell.messageLabel.frame = CGRect(x: 20, y: 0, width: estimatedFrame.width + 10, height: estimatedFrame.height + 20)
        cell.containerTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 40, y: heightTimeView, width: estimatedFrame.width + 40, height: estimatedFrame.height + 20)
        cell.profileImage.isHidden = true
        cell.bubbleImageView.image = MessageTextViewCell.blueBubble
        cell.bubbleImageView.tintColor = UIColor(white: 0.9, alpha: 1)
    }

    func getHeightTimeView(index: Int, cell: MessageTextViewCell) -> CGFloat {
        var heightTimeView: CGFloat = 20
        if (index - 1 >= 0) && (tmpData[index - 1].isSender == tmpData[index].isSender) {
            cell.timeView.isHidden = true
            heightTimeView = 0
        }
        return heightTimeView
    }
}
