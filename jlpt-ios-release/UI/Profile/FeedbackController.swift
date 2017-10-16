//
//  FeedbackController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class FeedbackController: UIViewController {
    @IBOutlet weak var titleFeedback: UITextField!
    @IBOutlet weak var contentFeedback: UITextField!
    
    @IBOutlet weak var sendFeedbackBtn: UIButton! {
        didSet {
            sendFeedbackBtn.setUpJLPTButton()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
