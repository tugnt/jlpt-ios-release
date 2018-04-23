//
//  ShowDocumentViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/01/14.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import WebKit

class ShowDocumentViewController: UIViewController {
    private var webView: WKWebView!
    var documentUrl: URL!

    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: documentUrl)
        webView.load(request)
    }
}
