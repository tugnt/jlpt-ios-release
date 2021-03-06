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
    private var webView: UIWebView!
    var documentUrl: URL!

    override func loadView() {
        super.loadView()
        self.setUpNavBar()
        webView = UIWebView(frame: view.bounds)
        view.addSubview(webView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let request = URLRequest(url: documentUrl)
        webView.loadRequest(request)
        webView.scalesPageToFit = true
    }
}

extension ShowDocumentViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.startAnimationLoading()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.stopAnimationLoading()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.stopAnimationLoading()
        self.showAlertDialog(title: "Thông báo", content: "Không tìm thấy tập tin trên máy.", titleButton: "Trở về", cancelAction: {
            self.navigationController?.popViewController(animated: true)
        })
    }
}
