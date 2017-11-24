//
//  DocumentCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/22.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

struct DocumentItem {
    let thumnailUrl: String
    let nameBook: String
    let bookUrl: String
}

protocol DocumentCellDelegate: class {
    func cell(_ didSelected: DocumentCell)
}

class DocumentCell: UITableViewCell {
    @IBOutlet weak var thumbnailBookImage: UIImageView!
    @IBOutlet weak var nameBookLbl: UILabel! {
        didSet {
            nameBookLbl.text = "Shinkanzen N2 dokkai"
        }
    }

    @IBOutlet weak var downloadBookBtn: UIButton! {
        didSet {
            downloadBookBtn.setImage(UIImage.fontAwesomeIcon(name: .cloudDownload, textColor: .lightGray, size: CGSize(width: downloadBookBtn.bounds.width, height: downloadBookBtn.bounds.height)), for: .normal)
        }
    }
    @IBOutlet weak var downloadProgress: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        downloadBookBtn.addTarget(self, action: #selector(startDownloadBook), for: .touchUpInside)
    }

    @objc func startDownloadBook() {
        // Todo: Start download and update progress here
        // Update image of button after download
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
