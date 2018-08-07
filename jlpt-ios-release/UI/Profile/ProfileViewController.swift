//
//  ProfileViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift
import Realm
import Alamofire
import AlamofireImage
import Firebase

class ProfileViewController: UIViewController {
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
            logoutBtn.layer.cornerRadius = 3
            if Account.checkoutUserLogin() {
                logoutBtn.backgroundColor = ColorName.logoutBtn.color
            } else {
                logoutBtn.backgroundColor = #colorLiteral(red: 0.1570000052, green: 0.5839999914, blue: 1, alpha: 1)
                logoutBtn.setTitle("Đăng nhập", for: .normal)
                logoutBtn.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private let settingItems: [String] = ["Chi tiết tài khoản",
                                          "Phản hồi và chia sẻ",
                                          "Cài đặt ứng dụng",
                                          "Điều khoản sử dụng"]
    private var isLogin: Bool! {
        didSet {
            self.logoutBtn.isEnabled = isLogin
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tài khoản"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        setUpNavBar()
        fetchAccountAndUpdateUI()
        logoutBtn.addTarget(self, action: #selector(handleAuth), for: .touchUpInside)
    }

    private func fetchAccountAndUpdateUI() {
        if Account.checkoutUserLogin() {
            guard let account = Account.getAccount() else { return }
            userNameLabel.text = account.userName != nil ? account.userName : "Guess"
            emailLabel.text = account.email != nil ? account.email : "example@email.com"
            if let urlString = account.photoUrl {
                Alamofire.request(urlString).responseImage { response in
                    if let image = response.result.value {
                        self.profileImage.image = image
                    }
                }
            }
        }
    }

    @objc private func handleAuth() {
        Account.checkoutUserLogin() ? logout() : moveLoginScreen()
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            self.moveLoginScreen()
        } catch {
            let alertModalView = TDModalStatusView(frame: view.bounds)
            alertModalView.setTitleLabel(title: "Thông báo")
            alertModalView.setSubTitleLabel(subTitle: "Đăng xuất thất bại")
            alertModalView.setStatusImage(image: Asset.notificationIcon.image)
            view.addSubview(alertModalView)
        }
    }
    
    private func moveLoginScreen() {
        let vc = StoryboardScene.LoginViewController.loginViewController.instantiate()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = vc
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
            controlller = StoryboardScene.EditProfileViewController.editProfileViewController.instantiate()
        case 1:
            controlller = StoryboardScene.NendBannerViewController.nendBannerViewController.instantiate()
                //StoryboardScene.FeedBackViewController.feedbackViewController.instantiate()
        case 2:
            // Todo: Không dùng notification controller nữa. Mà thay vào đó màn hình setting. 
            controlller = StoryboardScene.NotificationViewController.notificationViewController.instantiate()
        case 3:
            controlller = StoryboardScene.PrivacyPolicyViewController.privacyPolicyViewController.instantiate()
        default:
            break
        }
        guard let vc = controlller else { return }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
