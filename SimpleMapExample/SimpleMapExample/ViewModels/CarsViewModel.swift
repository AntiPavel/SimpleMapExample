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
        dataReader.fetchCars { [weak self] result in
            _ = result.flatMap { cars -> Result<[Car], NetworkServiceError> in
                self?.cars = cars
                return cars.isEmpty ? .failure(.invalidUrl): .success(cars)
            }
        }
//        dataReader.fetchCars { [weak self] result in
//            switch result {
//            case .success(let cars):
//                self?.cars = cars
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
