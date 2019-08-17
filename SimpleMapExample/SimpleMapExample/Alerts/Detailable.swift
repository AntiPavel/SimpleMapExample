//
//  Detailable.swift
//  SimpleMapExample
//
//  Created by paul on 16/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit

protocol Detailable {
    func showDetails(_ car: Car,
                     completion: @escaping () -> Void)
    func showError(_ message: String, title: String)
}

extension Detailable where Self: UIViewController {
    
    func showDetails(_ car: Car,
                     completion: @escaping () -> Void) {
        let title = car.title ?? ""
        let details = "\(car.subtitle ?? "") \nTransmission type: \(car.transmissionType?.rawValue ?? "n/a") \nFuel type: \(car.fuelType) \nFuel level: \(car.fuelLevel) \nCleanliness: \(car.innerCleanliness ?? "n/a") \nColor: \(car.color)"
        let alertController = UIAlertController(title: title, message: details, preferredStyle: .actionSheet)
        alertController.addAction( UIAlertAction.init(title: "Ok",
                                                      style: .cancel,
                                                      handler: { (_) in completion() }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showError(_ message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
