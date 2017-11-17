//
//  ChatRoomController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class ChatRoomController: UICollectionViewController {
    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    /// IphoneX 対応
    lazy var bottomAreaHeight: CGFloat = {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaInsets.bottom
        }
        return 0
    }()
    let inputAreaHeight: CGFloat = 48
    var keyboardHeight: CGFloat = 0
    var isKeyboardShowing: Bool = false
    /// - Input area component
    let inputAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gửi", for: .normal)
        button.setTitleColor(ColorName.navBackground.color, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
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

    var tmpData: [CellConfigurator] = SampleMessageData.messages

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phòng trò chuyện"
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(MessageTextViewCell.self, forCellWithReuseIdentifier: MessageTextViewCell.identifier)

        setcollectionViewLayout()
        setUpInputArea()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Todo: validate text input
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    func setcollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 48, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        collectionView?.alwaysBounceVertical = true
        collectionView?.collectionViewLayout = layout
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

    @objc func sendMessage() {
        let newMessage = TextCellConfig.init(item: MessageTextModel(message: "UICollectionView, introduced in iOS 6, has become one of the most popular UI elements among iOS developers.", timeCreated: "Today", senderId: ""))
        tmpData.append(newMessage)
        let indexPath = IndexPath(item: tmpData.count - 1, section: 0)
        collectionView?.insertItems(at: [indexPath])
        collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }

    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboadFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
            keyboardHeight = keyboadFrame.cgRectValue.height
            isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            adjustCollectionOffset()
        }
    }

    private func adjustCollectionOffset() {
        bottomConstraint.constant = isKeyboardShowing ? -keyboardHeight : 0
        /// - Animation collection view when keyboard appear
        DispatchQueue.main.async {
            if self.isKeyboardShowing {
                let indexPath = IndexPath(row: self.tmpData.count - 1, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        }
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension ChatRoomController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tmpData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tmpData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = tmpData[indexPath.row]
        let message = item.estimatedHeight()
        let estimatedFrame = estimatedTextFrame(textMessage: message)
        print(message)
        return CGSize(width: UIScreen.main.bounds.width, height: estimatedFrame.height + 20)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextView.endEditing(true)
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
