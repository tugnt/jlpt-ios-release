//
//  GroupChatViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/19.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Firebase

class GroupChatViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var ref: DatabaseReference!
    var groups: [GroupChatModel] = []
    var index = 0
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
        createGroupData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func createGroupData() {
        let n1Group = GroupChatModel(title: "Group N1", description: "Nơi trao đổi về Tiếng Nhật cấp độ N1", leftImage: Asset.g1.image, topRightImage: Asset.g2.image, bottomRightImage: Asset.g3.image)
        let n2Group = GroupChatModel(title: "Group N2", description: "Nơi trao đổi về Tiếng Nhật cấp độ N2", leftImage: Asset.g4.image, topRightImage: Asset.g5.image, bottomRightImage: Asset.g6.image)
        let n3Group = GroupChatModel(title: "Group N3", description: "Nơi trao đổi về Tiếng Nhật cấp độ N3", leftImage: Asset.g7.image, topRightImage: Asset.g8.image, bottomRightImage: Asset.g9.image)
        let n4Group = GroupChatModel(title: "Group N4", description: "Nơi trao đổi về Tiếng Nhật cấp độ N4", leftImage: Asset.g12.image, topRightImage: Asset.g10.image, bottomRightImage: Asset.g11.image)
        let n5Group = GroupChatModel(title: "Group N5", description: "Nơi trao đổi về Tiếng Nhật cấp độ N5", leftImage: Asset.g13.image, topRightImage: Asset.g14.image, bottomRightImage: Asset.g15.image)
        groups = [n1Group, n2Group, n3Group, n4Group, n5Group]
        collectionView.reloadData()
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
        return groups.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupChatViewCell.identifier, for: indexPath) as? GroupChatViewCell else { return UICollectionViewCell() }
        cell.configure(data: groups[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// Todo: Move to group chat
        let realm = try? Realm()
        // Get first account
        let accounts = realm?.objects(Account.self)
        if accounts?.count == 0 && accounts != nil {
            let confirmDialog = TDConfirmDialog(frame: view.bounds)
            confirmDialog.set(title: "Thông báo")
            confirmDialog.set(message: "Vui lòng đăng nhập để sử dụng chức năng này.")
            confirmDialog.cancelButtonTitle = "Bỏ qua"
            confirmDialog.confirmButtonTitle = "Đăng ký"
            confirmDialog.confirmDidSelected = {
                let vc = StoryboardScene.Login.loginViewController.instantiate()
                vc.modalPresentationStyle = .overCurrentContext
                self.tabBarController?.tabBar.isHidden = true
                self.present(vc, animated: true, completion: nil)
            }
            view.addSubview(confirmDialog)
        } else {
            let vc = StoryboardScene.ChatRoom.chatRoomController.instantiate()
            ChatRoomController.account = accounts![0]
            let level = LevelJLPT(rawValue: "\(indexPath.row + 1)")
            vc.roomName = level
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
