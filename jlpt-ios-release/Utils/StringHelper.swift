//
//  StringHelper.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/04/16.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import Foundation

extension String {
    func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format: "%02x", byte)
        }
        return hexString
    }
}
