//
//  FeedbackViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift
import FirebaseDatabase

class FeedbackViewController: HidenKeyboardViewController {
    @IBOutlet weak var titleFeedbackTextField: UITextField!
    @IBOutlet weak var contentFeedbackTextView: UITextView!
    @IBOutlet weak var sendFeedbackBtn: UIButton!
    private var ref: DatabaseReference!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phản hồi & Chia sẻ"
        contentFeedbackTextView.delegate = self
        updateUI()
        feedbackContentValidation()
        sendFeedbackBtn.addTarget(self, action: #selector(sendFeedback), for: .touchUpInside)
    }

    @objc private func sendFeedback() {
        // Todo: Send feed back here
        guard let title = titleFeedbackTextField.text else { return }
        guard let content = contentFeedbackTextView.text else { return }
        startAnimationLoading()
        ref = Database.database().reference()
        ref.child("feedback")
            .childByAutoId()
            .setValue(["title": title, "content": content], withCompletionBlock: { (error, _) in
                self.stopAnimationLoading()
                let tdAlert = TDModalStatusView(frame: self.view.bounds)
                let image = error != nil ? Asset.notificationIcon.image : UIImage.fontAwesomeIcon(name: .check, textColor: .gray, size: CGSize(width: 130, height: 130))
                tdAlert.setStatusImage(image: image)
                tdAlert.setTitleLabel(title: "Thông báo")
                let subTitle: String = error != nil ? "Có lỗi xảy ra, xin vui lòng thử lại sau" : "Cảm ơn bạn đã gửi phản hồi"
                tdAlert.setSubTitleLabel(subTitle: subTitle)
                self.view.addSubview(tdAlert)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
        })
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

    private func feedbackContentValidation() {
        let titleValid = titleFeedbackTextField.rx.text.orEmpty.map { _ in
            (self.titleFeedbackTextField.text != "")
        }
        let contentValid = contentFeedbackTextView.rx.text.orEmpty.map { _ in
            (self.contentFeedbackTextView.text != "Nhập nội dung")
        }
        let allValid = Observable.combineLatest(titleValid, contentValid) { $0 && $1 }
        allValid.bind(to: sendFeedbackBtn.rx.isEnabled).disposed(by: disposeBag)
    }
}

extension FeedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentFeedbackTextView.textColor == .lightGray {
            contentFeedbackTextView.text = nil
            contentFeedbackTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if contentFeedbackTextView.textColor == .black && contentFeedbackTextView.text.isEmpty {
            contentFeedbackTextView.text = "Nhập nội dung"
            contentFeedbackTextView.textColor = .lightGray
        }
    }
}
