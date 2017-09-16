//
//  CategoryHeaderView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/16.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class CategoryHeaderView: UICollectionReusableView {

    let label = UILabel()
    
    static var identifier:String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader(){
        addSubview(label)
        addConstraintsWithFormat("V:|[v0]|", views: label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
