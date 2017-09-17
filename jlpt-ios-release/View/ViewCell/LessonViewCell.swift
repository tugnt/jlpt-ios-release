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
    let imageName: String
    let typeLesson: TypeLesson
    var typeJLPT: TypeJLPT
    var level: LevelJLPT?
    init(title: String, imageName: String, typeLesson: TypeLesson, typeJLPT: TypeJLPT, level: LevelJLPT?) {
        self.title = title
        self.imageName = imageName
        self.typeLesson = typeLesson
        self.typeJLPT = typeJLPT
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
}

enum LevelJLPT: String {
    case N1 = "1"
    case N2 = "2"
    case N3 = "3"
    case N4 = "4"
    case N5 = "5"
}

class LessonViewCell: BaseViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    var title: UILabel  = UILabel()
    var imageView: UIImageView = UIImageView()
    var lesson: ItemLesson?
    
    override func setUpView() {
        backgroundColor = .red
        // Todo: setup view here
        self.addSubview(title)
        self.addSubview(imageView)
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addConstraintsWithFormat("V:|[v0]-10-[v1]|", views: title,imageView)
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(lessonSelected))
        addGestureRecognizer(tap)
        showData()
    }
    
    @objc func lessonSelected() {
        print("Selected")
    }
    
    func showData () {
        title.text = "Show"
        let image = UIImage(named: "lesson")
        imageView.image = image
    }
}
