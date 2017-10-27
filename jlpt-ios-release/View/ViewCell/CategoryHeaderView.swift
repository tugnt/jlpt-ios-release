//
//  CategoryHeaderView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import SnapKit

struct CategoryHeader {
    let sectionColor: UIColor
    let title: String
    let detailDescription: String
    let sectionImage: UIImage
    var isExpanded: Bool
    init(sectionColor: UIColor, title: String, detailDescription: String, sectionImage: UIImage, isExpanded: Bool) {
        self.sectionColor = sectionColor
        self.title = title
        self.detailDescription = detailDescription
        self.sectionImage = sectionImage
        self.isExpanded = isExpanded
    }
}

protocol CategoryHeaderViewDelegate: class {
    func header(_ header: CategoryHeaderView, section: Int)
}

class CategoryHeaderView: UICollectionReusableView {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let levelImage = UIImageView()
    let bottomLine = UIView()
    var section: Int = 0
    weak var delegate: CategoryHeaderViewDelegate?
    static var identifier: String { return String(describing: self) }

    var headerItem: CategoryHeader? {
        didSet {
            guard let item = headerItem else { return }
            titleLabel.text = item.title
            descriptionLabel.text = item.detailDescription
            levelImage.image = item.sectionImage
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeader()
    }

    func setUpHeader() {
        addSubview(titleLabel)
        addSubview(levelImage)
        addSubview(descriptionLabel)
        addSubview(bottomLine)

        levelImage.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }

        /// - TODO: set font for label
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(levelImage.snp.right).offset(10)
            make.top.equalTo(levelImage.snp.top).offset(5)
        }

        /// - TODO: set font for description label
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }

        bottomLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.5 )
            make.bottom.equalToSuperview()
        }
        bottomLine.backgroundColor = ColorName.bottomHeaderLine.color
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(expandLessonSection))
        headerTap.numberOfTapsRequired = 1
        headerTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(headerTap)
        self.isUserInteractionEnabled = true
    }

    @objc func expandLessonSection () {
        print("Nao click")
        delegate?.header(self, section: section)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
