//
//  LessonController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

struct Section {
    let header: String
    let categories: [LessonCategory]
    init(header: String, categories: [LessonCategory]) {
        self.header = header
        self.categories = categories
    }
}

class LessonController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let categoryId = String(describing: CategoryViewCell.self)
    lazy var sections: [Section] = {
        let categoriesTip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "lesson_1", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                             LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "lesson_2", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                          ItemLesson(title: "Title 1", imageName: "lesson_3", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                             LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "lesson_4", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                          ItemLesson(title: "Title 1", imageName: "lesson_5", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionTip = Section(header: "Tips", categories: categoriesTip)
        
        return [sectionTip]
    }()
    
    let galazyImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = "Bài học"
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(CategoryViewCell.self, forCellWithReuseIdentifier: categoryId)
        collectionView?.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CategoryHeaderView.identifier)
        self.edgesForExtendedLayout = .init(rawValue: 0)
        /// - Add galaxy image background for Lesson Screen
        collectionView?.backgroundColor = UIColor(patternImage: UIImage(asset: Asset.galaxyBackground))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as? CategoryViewCell else {
            return UICollectionViewCell()
        }
        cell.itemLesson = sections[indexPath.section].categories[indexPath.row].itemLessons
        cell.cellLessonSelected = { (cell) in
            self.cellSecletec(cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier: CategoryHeaderView.identifier,
                                                                             for: indexPath) as? CategoryHeaderView
            headerView?.label.text = sections[indexPath.section].header
            return headerView!
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        /// - Fix lỗi có khoảng trắng giữa navigation bar và colleciton view
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func cellSecletec(_ cell: LessonViewCell) {
        if cell.lessonItem?.level != nil {
            /// - Move to list question of JLPT
        } else {
            /// - Move to list hint screen
            let type = cell.lessonItem?.typeJLPT
            let vc = StoryboardScene.ListHint.listHintController.instantiate()
            vc.type = type
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
