//
//  Account.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import RealmSwift

class Account: Object {
    @objc dynamic var userName: String? = ""
    @objc dynamic var email: String? = ""
    @objc dynamic var uid: String? = ""
    @objc dynamic var photoUrl: String? = ""
}
