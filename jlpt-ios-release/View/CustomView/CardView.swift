//
//  CardView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/05.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 1
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOffSetWidth: Int = 0
    @IBInspectable var shadowOffSetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
}
