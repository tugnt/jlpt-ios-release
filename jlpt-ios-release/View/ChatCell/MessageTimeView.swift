//
//  MessageTimeView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import SnapKit

class MessageTimeView: UIView {
    lazy var leftDidivingLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    lazy var rightDidivingLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(white: 0.8, alpha: 1)
        label.contentMode = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        addSubview(timeLabel)
        timeLabel.textAlignment = .center
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(100)
        }

        addSubview(leftDidivingLine)
        leftDidivingLine.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(timeLabel.snp.leading)
        }
        addSubview(rightDidivingLine)
        rightDidivingLine.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
            make.leading.equalTo(timeLabel.snp.trailing)
        }
        timeLabel.text = "30 Sep 2016"
    }

    func set(time: String) {
        timeLabel.text = time
    }
}
