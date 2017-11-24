//
//  FeedbackController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class FeedbackController: UIViewController {
    @IBOutlet weak var titleFeedback: UITextField!
    @IBOutlet weak var contentFeedbackTextView: UITextView!
    @IBOutlet weak var sendFeedbackBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phản hồi & Chia sẻ"
        contentFeedbackTextView.delegate = self
        updateUI()
    }

    private func updateUI() {
        contentFeedbackTextView.clipsToBounds = true
        contentFeedbackTextView.layer.cornerRadius = 4
        contentFeedbackTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentFeedbackTextView.layer.borderWidth = 0.3
        contentFeedbackTextView.textColor = .lightGray
        contentFeedbackTextView.text = "Nhập nội dung"
        // SetUp Button
        sendFeedbackBtn.setUpPrimaryButton()
    }
}

extension FeedbackController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentFeedbackTextView.textColor == .lightGray {
            contentFeedbackTextView.text = ""
            contentFeedbackTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if contentFeedbackTextView.textColor == .black && contentFeedbackTextView.text.isEmpty {
            contentFeedbackTextView.text = "Nhập tin nhắn"
            contentFeedbackTextView.textColor = .lightGray
        }
    }
}
