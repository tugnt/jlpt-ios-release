//
//  GroupChatViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/19.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class GroupChatViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phòng trò chuyện"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GroupChatViewCell.nib, forCellWithReuseIdentifier: GroupChatViewCell.identifier)
        setCollectionViewLayout()
    }

    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (UIScreen.main.bounds.width - 30 ) / 2
        let itemHeight: CGFloat = 195
        let totalCellWidth: CGFloat = itemWidth * 2
        let totalSpacing: CGFloat = 10
        let leftInsset = (UIScreen.main.bounds.width - CGFloat(totalSpacing + totalCellWidth)) / 2
        let rightInsset = leftInsset
        layout.sectionInset = UIEdgeInsets(top: 10, left: leftInsset, bottom: 10, right: rightInsset)
        layout.minimumLineSpacing = 10.0
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .vertical
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
    }
}

extension GroupChatViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    /**
        From N5 -> N1
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupChatViewCell.identifier, for: indexPath) as? GroupChatViewCell else { return UICollectionViewCell() }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// Todo: Move to group chat
    }
}
