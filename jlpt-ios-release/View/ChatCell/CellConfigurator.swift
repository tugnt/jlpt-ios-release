//
//  CellConfigurator.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/17.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    func estimatedHeight() -> String
}

class CollectionViewCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UICollectionViewCell {

    static var reuseId: String { return String(describing: CellType.self) }
    let item: DataType

    init(item: DataType) {
        self.item = item
    }

    func configure(cell: UIView) {
        guard let cellConfig = cell as? CellType else { return }
        cellConfig.configure(data: item)
    }

    func estimatedHeight() -> String {
        guard let message = item as? MessageTextModel else { return "" }
        return message.message
    }
}
