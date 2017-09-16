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
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

class LessonViewCell: BaseViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    var title: UILabel  = UILabel()
    var imageView: UIImageView = UIImageView()
    
    override func setUpView() {
        backgroundColor = .red
        // Todo: setup view here
        self.addSubview(title)
        self.addSubview(imageView)
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addConstraintsWithFormat("V:|[v0]-10-[v1]|", views: title,imageView)
        title.text = "Show "
        let image = UIImage(named: "lesson")
        imageView.image = image
    }
}
