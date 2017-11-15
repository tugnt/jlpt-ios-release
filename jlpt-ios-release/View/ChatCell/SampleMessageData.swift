//
//  SampleMessageData.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

import Foundation

struct Message {
    let message: String
    let time: String
    let isSender: Bool
}

class SampleMessageData {
    static var messages: [Message] = {
        let messages = [Message(message: "While none of this is what we are looking for, “initWithPickerView:title:subtitle:", time: "8 days ago", isSender: false),
                        Message(message: "A lightweight framework to build chat applications, made in Swift", time: "2 years ago", isSender: false),
                        Message(message: "A lightweight framework to build chat applications, made in Swift", time: "2 years ago", isSender: true),
                        Message(message: "A lightweight framework to build chat applications, made in Swift", time: "2 years ago", isSender: true),
                        Message(message: "A lightweight framework to build chat applications, made in Swift", time: "2 years ago", isSender: true),
                        Message(message: "While none of this is what we are looking for, “initWithPickerView:title:subtitle:", time: "8 days ago", isSender: false),
                        Message(message: "A lightweight framework to build chat applications, made in Swift", time: "2 years ago", isSender: false)]
        return messages
    }()
}
