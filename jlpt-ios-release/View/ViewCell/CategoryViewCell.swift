//
//  CategoryViewCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

import UIKit

struct LessonCategory {
    let itemLessons: [ItemLesson]
    init(itemLessons: [ItemLesson]) {
        self.itemLessons = itemLessons
    }
}

class CategoryViewCell: BaseViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let width: CGFloat = 70
    var itemLesson: [ItemLesson] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var sectionColor: UIColor?
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 70, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    var cellLessonSelected: ((LessonViewCell) -> Void)?
    
    override func setUpView() {
        addSubview(collectionView)
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LessonViewCell.self, forCellWithReuseIdentifier: LessonViewCell.identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemLesson.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonViewCell.identifier, for: indexPath) as? LessonViewCell else { return UICollectionViewCell ()}
        cell.lessonItem = itemLesson[indexPath.row]
        cell.sectionColor = self.sectionColor!
        cell.cellSelected = { (cell) in
            self.cellLessonSelected?(cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = width * CGFloat(itemLesson.count)
        let totalSpaceWidth: CGFloat = 10 * CGFloat((itemLesson.count) - 1)
        let leftInsset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpaceWidth)) / 2
        let rightInsset = leftInsset
        return UIEdgeInsets(top: 0, left: leftInsset, bottom: 0, right: rightInsset)
    }
}
