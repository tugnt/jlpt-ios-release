//
//  HintCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/04.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class HintCell: UITableViewCell {
    
    @IBOutlet weak var hintTitleLabel: UILabel!
    
    @IBOutlet weak var hintDescriptionLabel: UILabel!
    
    @IBOutlet weak var hintNumberQuestionLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var imagePassOrFailed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initial code here
            
    }
}
