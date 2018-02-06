//
//  DocumentCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/22.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

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
    @IBOutlet weak var nameBookLbl: UILabel!
    @IBOutlet weak var enNameBookLabel: UILabel!
    @IBOutlet weak var downloadDocumentButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    weak var delegate: DocumentCellDelegate?
    var document: DocumentReponse! {
        didSet {
            nameBookLbl.text = document.jpName
            enNameBookLabel.text = document.enName
            let urlString = document.documentImage
            Alamofire.request(urlString).responseImage { response in
                if let image = response.result.value {
                    self.thumbnailBookImage.image = image
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        downloadDocumentButton.addTarget(self, action: #selector(startDownloadBook), for: .touchUpInside)
        setUpUI()
    }

    private func setUpUI() {
        downloadDocumentButton.clipsToBounds = true
        downloadDocumentButton.layer.cornerRadius = 2
        /// NOT GOOD
        downloadDocumentButton.layer.borderColor = UIColor(rgb: 0x2895FF).cgColor
        downloadDocumentButton.layer.borderWidth = 1
        downloadDocumentButton.addTarget(self, action: #selector(startDownloadBook), for: .touchUpInside)
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 2
    }

    @objc func startDownloadBook() {
        // Todo: Start download and update progress here
        delegate?.cell(self)
        // Update image of button after download
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
