//
//  DocumentTypeCell.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/22.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

protocol DocumentTypeCellDelegate: class {
    func cell(_ cell: DocumentTypeCell, type: TypeJLPT)
}

class DocumentTypeCell: UITableViewCell {
    static var identifier: String { return String(describing: self)}
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var listeningBtn: UIButton!
    @IBOutlet weak var readingBtn: UIButton!
    @IBOutlet weak var grammarBtn: UIButton!
    @IBOutlet weak var vocabularyBtn: UIButton!

    @IBOutlet weak var readingLb: UILabel!
    @IBOutlet weak var grammaLb: UILabel!
    @IBOutlet weak var vocabularyLb: UILabel!
    @IBOutlet weak var listeningLb: UILabel!
    
    weak var delegate: DocumentTypeCellDelegate?
    
    var documentItem: DocumentHeader? {
        didSet {
            guard let item = documentItem else { return }
            /// - Button readding
            let readingTintedImage = Asset.reading.image.withRenderingMode(.alwaysTemplate)
            readingBtn.setImage(readingTintedImage, for: .normal)
            readingBtn.tintColor = item.color
            readingLb.textColor = item.color
            
            /// - Button grammar
            let grammarTintedImage = Asset.grammar.image.withRenderingMode(.alwaysTemplate)
            grammarBtn.setImage(grammarTintedImage, for: .normal)
            grammarBtn.tintColor = item.color
            grammaLb.textColor = item.color
            
            /// - Listening button
            let listeningTintedImage = Asset.listening.image.withRenderingMode(.alwaysTemplate)
            listeningBtn.setImage(listeningTintedImage, for: .normal)
            listeningBtn.tintColor = item.color
            listeningLb.textColor = item.color
            
            /// - Vocabulary button
            let vocabularTintedImage = Asset.kanji.image.withRenderingMode(.alwaysTemplate)
            vocabularyBtn.setImage(vocabularTintedImage, for: .normal)
            vocabularyBtn.tintColor = item.color
            vocabularyLb.textColor = item.color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        readingBtn.addTarget(self, action: #selector(readingSelected), for: .touchUpInside)
        listeningBtn.addTarget(self, action: #selector(listeningSelected), for: .touchUpInside)
        grammarBtn.addTarget(self, action: #selector(grammarSelected), for: .touchUpInside)
        vocabularyBtn.addTarget(self, action: #selector(vocabularySelected), for: .touchUpInside)
    }
    
    @objc func readingSelected() {
        delegate?.cell(self, type: .reading)
    }
    
    @objc func listeningSelected() {
        delegate?.cell(self, type: .listening)
    }
    
    @objc func grammarSelected() {
        delegate?.cell(self, type: .grammar)
    }
    
    @objc func vocabularySelected() {
        delegate?.cell(self, type: .vocabulary)
    }
}
