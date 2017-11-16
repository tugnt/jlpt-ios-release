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
    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    /// IphoneX 対応
    lazy var bottomAreaHeight: CGFloat = {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaInsets.bottom
        }
        return 0
    }()
    let inputAreaHeight: CGFloat = 48
    /// - Input area component
    let inputAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gửi", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.cameraBtn.image, for: .normal)
        return button
    }()

    let inputTextView: UITextView = {
        let inputTv = UITextView()
        inputTv.text = "Nhập tin nhắn"
        inputTv.textColor = .lightGray
        inputTv.isEditable = true
        inputTv.font = UIFont.systemFont(ofSize: 16)
        return inputTv
    }()

    let tmpData: [Message] = SampleMessageData.messages
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phòng trò chuyện"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageTextViewCell.self, forCellWithReuseIdentifier: MessageTextViewCell.identifier)
        setCollectionViewLayout()
        setUpInputArea()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
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
        sender ? updateRightMessage(index: indexPath.row, cell: cell) : updateLeftMessage(index: indexPath.row, cell: cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // - Estimate cell height and width
        let estimatedFrame = estimatedTextFrame(textMessage: tmpData[indexPath.row].message)
        let estimatedTimeViewHeight: CGFloat = ((indexPath.row - 1 >= 0) &&
            (tmpData[indexPath.row - 1].isSender) == tmpData[indexPath.row].isSender) ? 0 : 20
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20 + estimatedTimeViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextView.endEditing(true)
    }

    func setUpInputArea() {
        view.addSubview(inputAreaView)
        // Working not perfect with swift 3.2
        view.addConstraintsWithFormat("H:|[v0]|", views: inputAreaView)
        view.addConstraintsWithFormat("V:[v0(48)]", views: inputAreaView)
        bottomConstraint = NSLayoutConstraint(item: inputAreaView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)

        inputAreaView.addSubview(cameraButton)
        cameraButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }

        inputAreaView.addSubview(inputTextView)
        inputTextView.delegate = self
        inputTextView.snp.makeConstraints({ make in
            make.leading.equalTo(cameraButton.snp.trailing).offset(5)
            make.width.equalTo(UIScreen.main.bounds.width - 120)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
        })

        inputAreaView.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.height.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.leading.equalTo(inputTextView.snp.trailing).offset(5)
        }

        let didivingView = UIView()
        inputAreaView.addSubview(didivingView)
        didivingView.backgroundColor = .lightGray
        didivingView.snp.makeConstraints { make in
            make.width.top.leading.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboadFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardHeight = keyboadFrame.cgRectValue.height
            let keyboardAndInputHeight = keyboadFrame.cgRectValue.height + inputAreaHeight
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            bottomConstraint.constant = isKeyboardShowing ? -keyboardHeight : 0
            /// - Animation collection view when keyboard appear
            let contentSizeHeight = collectionView.contentSize.height
            var contentOffsetY = contentSizeHeight - (UIScreen.main.bounds.height - keyboardAndInputHeight) + 20 + bottomAreaHeight
            contentOffsetY = isKeyboardShowing ? contentOffsetY : contentSizeHeight - (UIScreen.main.bounds.height - inputAreaHeight) + 20 + bottomAreaHeight
            DispatchQueue.main.async {
                let topOffest: CGPoint = CGPoint(x: 0, y: contentOffsetY)
                self.collectionView.setContentOffset(topOffest, animated: true)
            }
            UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
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

extension ChatRoomController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if inputTextView.textColor == .lightGray {
            inputTextView.text = ""
            inputTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.textColor == .black && inputTextView.text.isEmpty {
            inputTextView.text = "Nhập tin nhắn"
            inputTextView.textColor = .lightGray
        }
    }
}
