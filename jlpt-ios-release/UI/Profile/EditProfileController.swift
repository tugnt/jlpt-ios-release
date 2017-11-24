//
//  EditProfileController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import AlamofireImage
import Alamofire

struct EditProfileItem {
    let titleProfile: TypeEditProfile
    let contentProfile: String
    init(titleProfile: TypeEditProfile, contentProfile: String) {
        self.titleProfile = titleProfile
        self.contentProfile = contentProfile
    }
}

enum TypeEditProfile: String {
    case name = "Tên hiển thị"
    case email = "Địa chỉ email"
    case password = "Mật khẩu"
    case statusAcount = "Trạng thái tài khoản"
}

class EditProfileController: UIViewController {
    fileprivate let cellId = "cellSettingEdit"
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.clipsToBounds = true
            let radius = min(profileImage.bounds.width, profileImage.bounds.height) / 2
            profileImage.layer.cornerRadius = radius
        }
    }
    @IBOutlet weak var changeProfileImgBtn: UIButton!
    @IBOutlet weak var saveChangeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var editItems: [EditProfileItem] = [EditProfileItem(titleProfile: .statusAcount, contentProfile: "Miễn phí"),
                                                EditProfileItem(titleProfile: .name, contentProfile: "Guess"),
                                                EditProfileItem(titleProfile: .email, contentProfile: "guess@example.com"),
                                                EditProfileItem(titleProfile: .password, contentProfile: "**************")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.title = "Chi tiết tài khoản"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAccountData()
    }

    private func fetchAccountData() {
        let realm = try? Realm()
        guard let accounts = realm?.objects(Account.self) else { return }
        if accounts.count != 0 {
            let account = accounts[0]
            editItems =  [EditProfileItem(titleProfile: .statusAcount, contentProfile: "Miễn phí"),
                          EditProfileItem(titleProfile: .name, contentProfile: account.userName ?? "Guess"),
                          EditProfileItem(titleProfile: .email, contentProfile: account.email ?? "guess@example.com"),
                          EditProfileItem(titleProfile: .password, contentProfile: "**************")]
            /// - Update Image Profile
            if let urlString = account.photoUrl {
                Alamofire.request(urlString).responseImage { response in
                    if let image = response.result.value {
                        self.profileImage.image = image
                    }
                }
            }
            tableView.reloadData()
        }
    }
}

extension EditProfileController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? EditProfileCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.editItem = editItems[indexPath.row]
        return cell
    }
}
