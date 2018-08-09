//
//  Account.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class Account: Object {
    @objc dynamic var userName: String? = ""
    @objc dynamic var email: String? = ""
    @objc dynamic var uid: String? = ""
    @objc dynamic var photoUrl: String? = ""
    
    static func getAccount() -> Account? {
        let realm = try? Realm()
        let accounts = realm?.objects(Account.self)
        return accounts?.first
    }
    
    static func checkoutUserLogin() -> Bool {
        guard let _ = getAccount() else { return false }
        return true
    }
}


class AdsReport: Object {
    @objc dynamic var network: String = ""
    @objc dynamic var numberRequest: Int = 0
    @objc dynamic var impression: Int = 0
    @objc dynamic var clicks: Int = 0
    @objc dynamic var ctr: Double = 0.0
    
    //static getReport()
}
