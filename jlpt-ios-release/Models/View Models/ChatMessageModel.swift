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
    let senderUrl: String
    let senderId: String
    let messageType: MessageType
    init(message: String, senderUrl: String, senderId: String, messageType: MessageType) {
        self.message = message
        self.senderUrl = senderUrl
        self.senderId = senderId
        self.messageType = messageType
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

enum MessageType: String {
    case text = "Text"
    case image = "Image"
}
