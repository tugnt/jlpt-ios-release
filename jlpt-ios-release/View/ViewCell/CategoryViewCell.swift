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
    private let cellId = "lessonId"
    private let cellLessonWidth: CGFloat = 80
    
    var itemLesson: [ItemLesson] = []
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func setUpView() {
        addSubview(categoryCollectionView)
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: categoryCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views: categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(LessonViewCell.self, forCellWithReuseIdentifier: LessonViewCell.identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemLesson.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonViewCell.identifier, for: indexPath) as? LessonViewCell
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellLessonWidth, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = cellLessonWidth * CGFloat(itemLesson.count)
        let totalSpaceWidth: CGFloat = 10 * CGFloat((itemLesson.count) - 1)
        let leftInsset = (categoryCollectionView.frame.size.width - CGFloat(totalCellWidth + totalSpaceWidth)) / 2
        let rightInsset = leftInsset
        return UIEdgeInsets(top: 0, left: leftInsset, bottom: 0, right: rightInsset)
    }
}
