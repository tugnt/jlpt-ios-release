//
//  NotificationViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController {
    @IBOutlet weak var fontSizeStepper: UIStepper!
    @IBOutlet weak var fontSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cài đặt ứng dụng"
        tableView.tableFooterView = UIView()
        settingFontSizeStepper()
    }
    
    private func settingFontSizeStepper() {
        self.settingLabelFontSize()
        fontSizeStepper.value = Double(Setting.fontSize)
        fontSizeStepper.minimumValue = 15
        fontSizeStepper.maximumValue = 25
        fontSizeStepper.autorepeat = true
        fontSizeStepper.addTarget(self, action: #selector(changeFontSize(_:)), for: .touchUpInside)
    }
    
    @objc private func changeFontSize(_ sender: UIStepper) {
        let fontSize = sender.value
        Setting.fontSize = Int(fontSize)
        self.settingLabelFontSize()
    }
    
    private func settingLabelFontSize() {
        let fontSize = CGFloat(Setting.fontSize)
        if Setting.fontSize != 0 {
            let font = UIFont.systemFont(ofSize: fontSize, weight: .thin)
            fontSizeLabel.font = font
        }
    }
}
