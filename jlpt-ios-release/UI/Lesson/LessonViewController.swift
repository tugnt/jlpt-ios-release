//
//  LessonViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

struct Section {
    var header: CategoryHeader
    let categories: [LessonCategory]
    init(header: CategoryHeader, categories: [LessonCategory]) {
        self.header = header
        self.categories = categories
    }
}

class LessonViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let categoryId = String(describing: CategoryViewCell.self)
    var sections: [Section] = LessonModel.lessonModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        collectionView?.backgroundColor = .white
        navigationItem.title = "Bài học"
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(CategoryViewCell.self, forCellWithReuseIdentifier: categoryId)
        collectionView?.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CategoryHeaderView.identifier)
        self.edgesForExtendedLayout = .init(rawValue: 0)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].header.isExpanded ? sections[section].categories.count : 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryId, for: indexPath) as? CategoryViewCell else {
            return UICollectionViewCell()
        }
        cell.itemLesson = sections[indexPath.section].categories[indexPath.row].itemLessons
        cell.sectionColor = sections[indexPath.section].header.sectionColor
        cell.cellLessonSelected = { (level, type) in
            self.cellSelected(level, type)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier: CategoryHeaderView.identifier,
                                                                             for: indexPath) as? CategoryHeaderView
            headerView?.headerItem = sections[indexPath.section].header
            headerView?.section = indexPath.section
            headerView?.delegate = self
            return headerView!
        default:
            assert(false, "Unexpected element kind")
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        /// - Fix lỗi có khoảng trắng giữa navigation bar và colleciton view
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func cellSelected(_ level: LevelJLPT?, _ type: TypeJLPT?) {
        if level != nil {
            let vc = StoryboardScene.ListJLPTQuestionViewController.listQuestionViewController.instantiate()
            vc.type = type
            vc.level = level
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = StoryboardScene.ListHintViewController.listHintController.instantiate()
            vc.type = type
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LessonViewController: CategoryHeaderViewDelegate {
    func header(_ header: CategoryHeaderView, section: Int) {
        sections[section].header.isExpanded = !sections[section].header.isExpanded
        collectionView?.reloadSections([section])
    }
}
