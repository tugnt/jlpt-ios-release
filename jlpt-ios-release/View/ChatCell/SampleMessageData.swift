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
        TextCellConfig.init(item: MessageTextModel(message: "UICollectionView, introduced in iOS 6, has become one of the most popular UI elements among iOS developers.", timeCreated: "Today", senderId: "")),
        TextCellConfig.init(item: MessageTextModel(message: "The layout is then responsible for determining the placement and visual attributes of the views.", timeCreated: "Today", senderId: "")),
        TextCellConfig.init(item: MessageTextModel(message: "CollectionViewCellConfigurator", timeCreated: "Today", senderId: "")),
        TextCellConfig.init(item: MessageTextModel(message: "In this UICollectionView custom layout tutorial, you’ll create a layout inspired by the popular Pinterest app.", timeCreated: "Today", senderId: "")),
        TextCellConfig.init(item: MessageTextModel(message: "UICollectionView Tutorial Part 1: Getting Started", timeCreated: "Today", senderId: "tung"))]
}
