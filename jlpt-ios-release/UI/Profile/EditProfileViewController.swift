//
//  EditProfileViewController.swift
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

class EditProfileViewController: UIViewController {
    fileprivate let cellId = "cellSettingEdit"
    @IBOutlet weak var tableView: UITableView!
    private var editItems: [EditProfileItem] = [EditProfileItem(titleProfile: .statusAcount, contentProfile: "Miễn phí"),
                                                EditProfileItem(titleProfile: .name, contentProfile: "guess"),
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
        if Account.checkoutUserLogin() {
            guard let account = Account.getAccount() else { return }
            editItems =  [EditProfileItem(titleProfile: .statusAcount, contentProfile: "Miễn phí"),
                          EditProfileItem(titleProfile: .name, contentProfile: account.userName ?? "Guess"),
                          EditProfileItem(titleProfile: .email, contentProfile: account.email ?? "guess@example.com"),
                          EditProfileItem(titleProfile: .password, contentProfile: "**************")]
            tableView.reloadData()
        }
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.selectionStyle = .none
        cell.editItem = editItems[indexPath.row]
        return cell
    }
}
