//
//  PrivacyPolicyViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    private var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Điều khoản sử dụng"
        webview = WKWebView(frame: view.bounds)
        view.addSubview(webview)
        guard let url = URL(string: "https://jlpt-api.herokuapp.com/privacy") else { return }
        let request = URLRequest(url: url)
        webview.load(request)
    }
}

// MARK: WKNavigationDelegate method implement

extension PrivacyPolicyViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startAnimationLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopAnimationLoading()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stopAnimationLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopAnimationLoading()
    }
}
