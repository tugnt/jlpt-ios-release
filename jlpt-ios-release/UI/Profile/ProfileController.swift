//
//  ProfileController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileController: UIViewController {
    fileprivate let cellId = "cellSetting"
    let disposerBag = DisposeBag()

    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.clipsToBounds = true
            profileImage.layer.cornerRadius = CGFloat(40)
        }
    }

    @IBOutlet weak var logoutBtn: UIButton! {
        didSet {
            logoutBtn.backgroundColor = ColorName.logoutBtn.color
            logoutBtn.layer.cornerRadius = CGFloat(5)
        }
    }

    @IBOutlet weak var tableView: UITableView!

    let settingItems: [String] = ["Cài đặt tài khoản",
                                  "Phản hồi và chia sẻ",
                                  "Thông báo",
                                  "Điều khoản và chính sách"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tài khoản"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = settingItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controlller: UIViewController?
        switch indexPath.row {
        case 0:
            controlller = StoryboardScene.EditProfile.editProfileController.instantiate()
        case 1:
            controlller = StoryboardScene.FeedBack.feedbackController.instantiate()
        case 2:
            controlller = StoryboardScene.Notification.notificationController.instantiate()
        case 3:
            controlller = StoryboardScene.PrivacyPolicy.privacyPolicyController.instantiate()
        default:
            break
        }
        guard let vc = controlller else { return }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
