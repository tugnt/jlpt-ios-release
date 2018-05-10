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
import Lottie

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
    var downloadDocumentProgress: (() -> Void)?
    let animationView = LOTAnimationView(contentsOf: URL(string: Env.animationLink)!)

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
            let fileExits = FileHelper.checkFileExits(documentUrl: document.linkDocument)
            if fileExits {
                downloadDocumentButton.setTitle("OPEN", for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        downloadDocumentButton.addTarget(self, action: #selector(startDownloadDocument), for: .touchUpInside)
        setUpUI()
    }

    private func setUpUI() {
        downloadDocumentButton.clipsToBounds = true
        downloadDocumentButton.layer.cornerRadius = 2
        downloadDocumentButton.layer.borderColor = #colorLiteral(red: 0.1570000052, green: 0.5839999914, blue: 1, alpha: 1)
        downloadDocumentButton.layer.borderWidth = 1
        downloadDocumentButton.addTarget(self, action: #selector(startDownloadDocument), for: .touchUpInside)
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 2
    }

    @objc private func startDownloadDocument() {
        downloadDocumentProgress?()
    }

    func addLoadingView() {
        downloadDocumentButton.isHidden = true
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
        }
        animationView.loopAnimation = true
        animationView.play()
    }

    func removeLoadingView() {
        animationView.stop()
        animationView.removeFromSuperview()
        downloadDocumentButton.isHidden = false
    }
}
