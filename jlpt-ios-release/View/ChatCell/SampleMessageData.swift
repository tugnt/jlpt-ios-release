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
        TextCellConfig.init(item: MessageTextModel(message: "UICollectionView, introduced in iOS 6, has become one of the most popular UI elements among iOS developers.", senderUrl: "Today", senderId: "", messageType: .text))]
}
