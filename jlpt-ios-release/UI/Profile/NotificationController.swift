//
//  NotificationController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class NotificationController: UITableViewController {
    @IBOutlet weak var allowAppUpdateSwitch: UISwitch!
    @IBOutlet weak var allowPushNotifiDocSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cài đặt ứng dụng"
        tableView.tableFooterView = UIView()
    }
}
