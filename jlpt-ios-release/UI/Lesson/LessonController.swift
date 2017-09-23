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
        let categoriesTip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                             LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                          ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                             LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                          ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionTip = Section(header: "Tips", categories: categoriesTip)
        
        let jlptN1Tip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionJlptN1 = Section(header: "JlptN1", categories: jlptN1Tip)
        
        let jlptN2Tip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionJlptN2 = Section(header: "JlptN2", categories: jlptN2Tip)
        
        let jlptN3Tip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionJlptN3 = Section(header: "JlptN3", categories: jlptN3Tip)
        
        let jlptN4Tip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionJlptN4 = Section(header: "JlptN4", categories: jlptN4Tip)
        
        let jlptN5Tip = [LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)]),
                         LessonCategory(itemLessons: [ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil),
                                                      ItemLesson(title: "Title 1", imageName: "imagename", typeLesson: .tip, typeJLPT: .reading, level: nil)])]
        let sectionJlptN5 = Section(header: "JlptN5", categories: jlptN5Tip)
        
        return [sectionTip, sectionJlptN1, sectionJlptN2, sectionJlptN3, sectionJlptN4, sectionJlptN5]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = "Lesson"
        collectionView?.register(CategoryViewCell.self, forCellWithReuseIdentifier: categoryId)
        collectionView?.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CategoryHeaderView.identifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as? CategoryViewCell
        cell?.itemLesson = sections[indexPath.section].categories[indexPath.row].itemLessons
        return cell!
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
}
