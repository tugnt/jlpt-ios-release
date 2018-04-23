//
//  FileHelper.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2018/04/18.
//  Copyright © 2018 Nguyen Trong Tung. All rights reserved.
//

import Foundation

class FileHelper {
    static func createDocumentSavePath(documentUrl: String) -> URL {
        var fileName = (documentUrl as NSString).lastPathComponent
        fileName = fileName.md5(fileName)
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let savePath = documentsURL.appendingPathComponent("\(fileName).pdf")
        return savePath
    }

    static func checkFileExits(documentUrl: String) -> Bool {
        let saveFilePath = FileHelper.createDocumentSavePath(documentUrl: documentUrl)
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: saveFilePath.path)
    }
}
