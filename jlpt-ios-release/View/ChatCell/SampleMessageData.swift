//
//  SampleMessageData.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
typealias TextCellConfig = CollectionViewCellConfigurator<MessageTextViewCell, MessageTextModel>
typealias ImageCellConfig = CollectionViewCellConfigurator<MessageImageViewCell, MessageImageModel>

class SampleMessageData {
    static var messages: [CellConfigurator] = [
        TextCellConfig.init(item: MessageTextModel(message: """
                            Chào mừng bạn đến với phòng trò chuyện.
                            Đây là nơi trao đổi các vấn đề về học tập tiếng Nhật cũng như các chủ đề liên quan.
                            Các hành vi cố ý vi phạm điều khoản sẽ bị xoá tài khoản.
                            Hãy góp phần tạo một cộng đồng tiếng Nhật văn minh. Chúc các bạn có một ngày vui vẻ
                            """, senderUrl: "Now", senderId: "", messageType: .text))]
}
