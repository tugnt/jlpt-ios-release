//
//  TheoryHintController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/06.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import MarkdownView

class TheoryHintController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mdView = MarkdownView()
        view.addSubview(mdView)
        mdView.translatesAutoresizingMaskIntoConstraints = false
        mdView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        mdView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mdView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mdView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        guard let url = URL(string: "https://raw.githubusercontent.com/keitaoouchi/MarkdownView/master/sample.md") else { return }
        let markdown = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        // Load content from here
        mdView.load(markdown: markdown, enableImage: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
