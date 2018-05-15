//
//  DocumentExpandHeaderView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/18.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

struct DocumentHeader {
    let color: UIColor
    let image: UIImage
    let title: String
    let titleNumberDocument: String
    var isExpanded: Bool
    let level: LevelJLPT
    init(color: UIColor, image: UIImage, title: String, titleNumberDocument: String, isExpanded: Bool, level: LevelJLPT) {
        self.color = color
        self.image = image
        self.title = title
        self.titleNumberDocument = title
        self.isExpanded = isExpanded
        self.level = level
    }
}

protocol DocumentHeaderViewDeleagate: class {
    func header(didSelected header: DocumentExpandHeaderView, section: Int)
}

class DocumentExpandHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var contentHeaderView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var jlptImageView: UIImageView!
    var isHeaderSelected: Bool = false
    var section: Int?
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    weak var delegate: DocumentHeaderViewDeleagate?

    var headerItem: DocumentHeader? {
        didSet {
            guard let header = headerItem else { return }
            titleLbl.text = header.title
            subTitleLbl.text = header.titleNumberDocument
            jlptImageView.image = header.image
            isHeaderSelected = header.isExpanded
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .red
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(expandHeaderDocument))
        headerTap.numberOfTapsRequired = 1
        headerTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(headerTap)
        self.isUserInteractionEnabled = true
    }

    @objc func expandHeaderDocument() {
        delegate?.header(didSelected: self, section: section!)
    }
}
