//
//  PrivacyPolicyController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class PrivacyPolicyController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://medium.com/@reinman/its-reboot-time-for-operating-systems-6a516ad8e89c")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}
