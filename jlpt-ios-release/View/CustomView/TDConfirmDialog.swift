//
//  TDConfirmDialog.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/10.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class TDConfirmDialog: UIView {
    var contentView: UIView!
    var nibName: String = "TDConfirmDialog"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    var cancelDidSelected: (() -> Void)?
    var confirmDidSelected: (() -> Void)?
    var cancelButtonTitle: String = "Huỷ" {
        didSet {
            cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
    }
    var confirmButtonTitle: String = "OK" {
        didSet {
            confirmButton.setTitle(confirmButtonTitle, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let dialogView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        self.contentView = dialogView
        contentView.backgroundColor = .white
        addSubview(contentView)
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.alpha = 0.0

        titleLabel.text = ""
        messageLabel.text = ""

        cancelButton.setUpDangerButton()
        cancelButton.backgroundColor = .white
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissDialog), for: .touchUpInside)

        confirmButton.setUpPrimaryButton()
        confirmButton.setTitle(confirmButtonTitle, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmSelected), for: .touchUpInside)
    }

    override func layoutSubviews() {
        self.layoutIfNeeded()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }

    func set(title: String) {
        titleLabel.text = title
    }

    func set(message content: String) {
        messageLabel.text = content
    }

    // Set animation when move to super view
    override func didMoveToSuperview() {
        self.contentView.transform  = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1
            self.contentView.transform  = .identity
        })
    }

    @objc func dismissDialog() {
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }, completion: { _ in
            self.cancelDidSelected?()
            self.removeFromSuperview()
        })
    }

    @objc func confirmSelected() {
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }, completion: { _ in
            self.confirmDidSelected?()
            self.removeFromSuperview()
        })
    }
}
