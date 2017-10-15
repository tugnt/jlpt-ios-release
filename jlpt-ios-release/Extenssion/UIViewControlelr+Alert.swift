//
//  UIViewControlelr+Alert.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/15.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertDialog(title: String, content: String, titleButton: String, cancelAction: @escaping ()->()?) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: titleButton, style: .cancel, handler:{ (_) in
            cancelAction()
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showInputDialog(title: String, message: String, okButton: String, cancelButton: String, okAction: @escaping ()->()?, cancelAction: @escaping ()->()? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAct = UIAlertAction(title: okButton, style: .default, handler: { (_) in
            okAction()
        })
        let cancelAct = UIAlertAction(title: cancelButton, style: .destructive, handler: { (_) in
            cancelAction()
        })
        
        alertController.addAction(confirmAct)
        alertController.addAction(cancelAct)
        alertController.addTextField(configurationHandler: { (textField) in
            
        })
        
        self.present(alertController, animated: true, completion: nil)
    }

}


