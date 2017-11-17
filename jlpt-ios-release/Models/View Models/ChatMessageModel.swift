//
//  ChatMessageModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/17.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

struct MessageTextModel {
    let message: String
    let timeCreated: String
    let senderId: String
    init(message: String, timeCreated: String, senderId: String) {
        self.message = message
        self.timeCreated = timeCreated
        self.senderId = senderId
    }
}

struct MessageImageModel {
    let senderId: String
    let timeCreated: String
    let linkImage: String
    init(senderId: String, timeCreated: String, linkImage: String) {
        self.senderId = senderId
        self.timeCreated = timeCreated
        self.linkImage = linkImage
    }
}
