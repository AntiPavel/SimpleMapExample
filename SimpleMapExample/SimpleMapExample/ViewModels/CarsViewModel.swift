//
//  CarsViewModel.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation

class CarsViewModel {
    
    weak var viewController: TabBarViewController? {
        didSet {
            if viewController != nil {
                update()
            }
        }
    }

    var cars: [Car] = [] {
        didSet {
            viewController?.update()
        }
    }
    var dataReader: DataReader
    init(reader: DataReader) {
        dataReader = reader
    }
    
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.addSpinner()
        }
        dataReader.fetchCars { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.removeSpinner()
                switch result {
                case .success(let cars):
                    self?.cars = cars
                case .failure(let error):
                    self?.viewController?.showError(error)
                }
            }
        }
    }
}
