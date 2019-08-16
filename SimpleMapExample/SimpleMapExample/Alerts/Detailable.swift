//
//  Detailable.swift
//  SimpleMapExample
//
//  Created by paul on 16/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit

protocol Detailable {
    func showDetails(_ message: String,
                     title: String,
                     options: String...,
                     completion: @escaping (Int) -> Void)
    func showError(_ message: String, title: String)
}

extension Detailable where Self: UIViewController {
    func showDetails(_ message: String,
                     title: String,
                     options: String...,
                     completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, option) in options.enumerated() {

            alertController.addAction(UIAlertAction.init(title: option, style: .cancel, handler: { (_) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showError(_ message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
