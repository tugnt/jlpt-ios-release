//
//  LessonViewCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

struct ItemLesson {
    let title: String
    let image: UIImage
    let typeLesson: TypeLesson
    var typeJLPT: TypeJLPT
    var level: LevelJLPT?
    let isHaveRightLine: Bool
    let isHaveLeftLine: Bool
    init(title: String, image: UIImage, typeLesson: TypeLesson, typeJLPT: TypeJLPT, level: LevelJLPT?, isHaveRightLine: Bool, isHaveLeftLine: Bool) {
        self.title = title
        self.image = image
        self.typeLesson = typeLesson
        self.typeJLPT = typeJLPT
        self.isHaveRightLine = isHaveRightLine
        self.isHaveLeftLine = isHaveLeftLine
        if typeLesson == .jlpt {
            self.level = level
        } else {
            self.level = nil
        }
    }
}

enum TypeLesson: String {
    case tip = "tips"
    case jlpt = "jlpt"
}

enum TypeJLPT: String {
    case reading = "Reading"
    case listening = "Listening"
    case grammar = "Grammar"
    case vocabulary = "Vocabulary"
    case kanji = "Kanji"
}

enum LevelJLPT: String {
    case n1 = "1"
    case n2 = "2"
    case n3 = "3"
    case n4 = "4"
    case n5 = "5"
}

protocol LessonCellDelegate:class {
    func cellDidSelected(level: LevelJLPT, type: TypeJLPT)
}

class LessonViewCell: BaseViewCell {
    static var identifier: String { return String(describing: self) }

    private let title: UILabel  = UILabel()
    private let imageView: UIImageView = UIImageView()
    private let circleView = UIView()
    private let leftBrigeLine = UIView()
    private let rightBrigeLine = UIView()
    private var level: LevelJLPT?
    private var type: TypeJLPT?
    var cellSelected: ((LevelJLPT?, TypeJLPT?) -> Void)?
    var lesson: ItemLesson?
    var sectionColor: UIColor = .gray {
        didSet {
            leftBrigeLine.backgroundColor = sectionColor
            rightBrigeLine.backgroundColor = sectionColor
            title.textColor = sectionColor
            circleView.layer.borderColor = sectionColor.cgColor
            imageView.tintColor = sectionColor
        }
    }

    var lessonItem: ItemLesson? {
        didSet {
            guard let item = lessonItem else { return }
            title.text = item.title
            let imageTint = item.image.withRenderingMode(.alwaysTemplate)
            imageView.image = imageTint
            leftBrigeLine.isHidden = !item.isHaveLeftLine
            rightBrigeLine.isHidden = !item.isHaveRightLine
            level = item.level
            type = item.typeJLPT
        }
    }
    private let circleRadius: CGFloat = 60
    private let circlePadding: CGFloat = 5
    private let itemHeight: CGFloat = 70

    /// - Setup view here
    override func setUpView() {
        addSubview(title)
        addSubview(circleView)
        addSubview(leftBrigeLine)
        addSubview(rightBrigeLine)
        circleView.addSubview(imageView)

        leftBrigeLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((circleRadius + circlePadding) / 2)
            make.height.equalTo(3)
            make.width.equalTo((itemHeight - circleRadius) / 2)
        }

        rightBrigeLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((circleRadius + circlePadding) / 2)
            make.height.equalTo(3)
            make.width.equalTo((itemHeight - circleRadius) / 2)
            make.right.equalToSuperview()
        }

        circleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.height.width.equalTo(circleRadius)
            make.centerX.equalToSuperview()
        }
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = circleRadius / 2
        circleView.layer.borderWidth = 2

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(30)
        }
        imageView.contentMode = .scaleAspectFill

        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(circleView.snp.bottom)
        }
        title.font = UIFont.systemFont(ofSize: 13)

        /// - Set tap gesture event
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(lessonSelected))
        addGestureRecognizer(tap)
    }

    @objc func lessonSelected() {
        self.cellSelected?(level, type)
    }
}
