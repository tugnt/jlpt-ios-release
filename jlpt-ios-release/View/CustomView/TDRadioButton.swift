//
//  TDRadioButton.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/09.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
let piVal: CGFloat = CGFloat(Double.pi)
@IBDesignable class TDRadioButton: UIButton {
    @IBInspectable var isClicked: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var nomalColor: UIColor = .gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var selectedColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var selectedFillColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var widthArc: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let radius = min(bounds.width / 2, bounds.height / 2)
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let outLinePath = UIBezierPath(arcCenter: center, radius: radius - widthArc, startAngle: 0, endAngle: 2 * piVal, clockwise: true)
        outLinePath.lineWidth = widthArc
        if isClicked { selectedColor.setStroke() }
        else { nomalColor.setStroke() }
        outLinePath.stroke()
        if isClicked {
            // if true will draw fillCircle
            drawFillCircle(center: center, radius: radius  * 0.5)
        }
    }
    
    func drawFillCircle (center: CGPoint, radius: CGFloat) {
        let pathFillCircle = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * piVal, clockwise: true)
        pathFillCircle.lineWidth = radius
        selectedColor.setFill()
        pathFillCircle.fill()
    }
}
