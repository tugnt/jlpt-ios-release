//
//  ProfileController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import Realm
import Alamofire
import AlamofireImage
import Firebase

class ProfileController: UIViewController {
    fileprivate let cellId = "cellSetting"
    let disposerBag = DisposeBag()
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
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
    @IBOutlet weak var logoutButton: UIButton!
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
        setUpNavBar()
        fetchAccountAndUpdateUI()
        logoutBtn.addTarget(self, action: #selector(logoutHandle), for: .touchUpInside)
    }

    private func fetchAccountAndUpdateUI() {
        let realm = try? Realm()
        guard let accounts = realm?.objects(Account.self) else { return }
        if accounts.count != 0 {
            let account = accounts[0]
            /// Update label
            userNameLabel.text = account.userName != nil ? account.userName : "Guess"
            emailLabel.text = account.email != nil ? account.email : "example@email.com"
            /// - Update Image Profile
            if let urlString = account.photoUrl {
                Alamofire.request(urlString).responseImage { response in
                    if let image = response.result.value {
                        self.profileImage.image = image
                    }
                }
            }
        }
    }

    @objc private func logoutHandle() {
        do {
            try Auth.auth().signOut()
            let vc = StoryboardScene.Login.loginViewController.instantiate()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.window?.rootViewController = vc
        } catch let logoutError {
            print(logoutError.localizedDescription)
            let alertModalView = TDModalStatusView(frame: view.bounds)
            alertModalView.setTitleLabel(title: "Thông báo")
            alertModalView.setSubTitleLabel(subTitle: "Đăng xuất thất bại")
            alertModalView.setStatusImage(image: Asset.notificationIcon.image)
            view.addSubview(alertModalView)
        }
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
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .thin)
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
