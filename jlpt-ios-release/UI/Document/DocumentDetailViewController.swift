//
//  DocumentDetailViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/02/07.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import WebKit
import UIKit

class DocumentDetailViewController: UIViewController, UIWebViewDelegate {
    private var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView(frame: self.view.bounds)
        view.addSubview(webView)
        // Todo: Load pdf file from local
    }
}
