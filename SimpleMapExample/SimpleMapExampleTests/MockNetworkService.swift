//
//  MockNetworkService.swift
//  SimpleMapExampleTests
//
//  Created by paul on 18/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
@testable import SimpleMapExample

final class MockNetworkService: DataReader {
    
    func fetchCars(result: @escaping (Result<[Car], NetworkServiceError>) -> Void) {
        let decoder = JSONDecoder()
        guard let url: URL = Bundle(for: type(of: self)).url(forResource: "cars", withExtension: "json"),
        let jsonData = try? Data(contentsOf: url),
            let cars = try? decoder.decode([Car].self, from: jsonData) else {
                fatalError("MockNetworkService unable to read the json file")
        }
        result(.success(cars))
    }
    
}
