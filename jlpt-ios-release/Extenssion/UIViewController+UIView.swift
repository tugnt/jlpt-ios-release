//
//  UIViewController+UIView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {

    func showTransparentView() {
        let transparentView = UIView(frame: self.view.frame)
        transparentView.tag = 101
        transparentView.center = view.center
        transparentView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        self.view.addSubview(transparentView)
        addEditView()
    }

    func removeTransparentView() {
        guard let viewWithTag = self.view.viewWithTag(101) else { return }
        viewWithTag.removeFromSuperview()
    }
// swiftlint:disable function_body_length
    func addEditView() {
        let editView = CardView()
        editView.backgroundColor = .white
        editView.layer.cornerRadius = CGFloat(5)
        editView.clipsToBounds = true
        self.view.addSubview(editView)
        editView.snp.makeConstraints({ (make) in
            make.center.equalTo(self.view.center)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(220)
        })

        let backgroundTitleLabel = UIView()
        editView.addSubview(backgroundTitleLabel)
        backgroundTitleLabel.backgroundColor = ColorName.logoutBtn.color
        backgroundTitleLabel.snp.makeConstraints({ (make) in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(50)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        })

        let titelLabel = UILabel()
        titelLabel.textColor = .black
        titelLabel.text = "Thay đổi thông tin"
        backgroundTitleLabel.addSubview(titelLabel)
        titelLabel.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })

        let subTitleLabel = UILabel()
        editView.addSubview(subTitleLabel)
        subTitleLabel.font = subTitleLabel.font.withSize(13)
        subTitleLabel.text = "Vui lòng điền thông tin thay đổi."
        subTitleLabel.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        })

        let textField = UITextField()
        textField.placeholder = "Thông tin cần điền"
        textField.borderStyle = .roundedRect
        editView.addSubview(textField)
        textField.snp.makeConstraints({ (make) in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        })

        let cancelBtn = UIButton()
        cancelBtn.setTitle("Huỷ bỏ", for: .normal)
        cancelBtn.setTitleColor(.red, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelEditInfo), for: .touchUpInside)
        cancelBtn.layer.cornerRadius = CGFloat(3)
        editView.addSubview(cancelBtn)
        cancelBtn.backgroundColor = ColorName.logoutBtn.color
        cancelBtn.snp.makeConstraints({ (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
        })

        let changeBtn = UIButton()
        changeBtn.setTitle("Thay đổi", for: .normal)
        changeBtn.addTarget(self, action: #selector(changeUserInfo), for: .touchUpInside)
        changeBtn.layer.cornerRadius = CGFloat(3)
        editView.addSubview(changeBtn)
        changeBtn.backgroundColor = ColorName.navBackground.color
        changeBtn.snp.makeConstraints({ (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        })
    }

    @objc func cancelEditInfo() {
        removeTransparentView()
    }

    @objc func changeUserInfo() {
    }
}
