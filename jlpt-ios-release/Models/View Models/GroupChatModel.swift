//
//  GroupChatModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/23.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct GroupChatModel {
    let title: String
    let description: String
    let leftImage: UIImage
    let topRightImage: UIImage
    let bottomRightImage: UIImage

    init(title: String, description: String, leftImage: UIImage, topRightImage: UIImage, bottomRightImage: UIImage) {
        self.title = title
        self.description = description
        self.leftImage = leftImage
        self.topRightImage = topRightImage
        self.bottomRightImage = bottomRightImage
    }
}
