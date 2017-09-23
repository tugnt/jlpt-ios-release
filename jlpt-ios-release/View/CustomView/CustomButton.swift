//
//  CustomButton.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/24.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var withBorder: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var fillBackgroundColor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var strokeColor: CGColor = UIColor.lightGray.cgColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var isExpanded: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.borderWidth = withBorder
        layer.cornerRadius = cornerRadius
        layer.borderColor = strokeColor
        let imageWidth: CGFloat = 15.0
        let imageHeight: CGFloat = 15.0
        let imageOriginX = CGFloat(bounds.width - CGFloat(imageWidth))
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        let imageRect = CGRect(x: imageOriginX - 10, y: CGFloat(bounds.height / 2 - imageHeight / 2), width: imageWidth, height: imageHeight)
        rightImage?.draw(in: imageRect, blendMode: .normal, alpha: 1)
        //todo: add　animation image
    }
}
