//
//  EditProfileController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

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
    let editItems: [EditProfileItem] = [EditProfileItem(titleProfile: .statusAcount, contentProfile: "Miễn phí"),
                                      EditProfileItem(titleProfile: .name, contentProfile: "Tung Nguyen"),
                                      EditProfileItem(titleProfile: .email, contentProfile: "tungnguyenlee2t@gmail.com"),
                                      EditProfileItem(titleProfile: .password, contentProfile: "**************")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showTransparentView()
//        showInputDialog(title: "Test", message: "Test", okButton: "OK", cancelButton: "Cancel", okAction: {
//            print("OK")
//        }, cancelAction: {
//            print("Cancel")
//        })
    }
}
