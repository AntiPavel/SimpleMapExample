//
//  NetworkService.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
import UIKit

enum Endpoint: String {
    case cars
}

public protocol DataReader {
    func fetchCars(result: @escaping (Result<[Car], NetworkServiceError>) -> Void)
}

public struct NetworkService: DataReader {

    public init() {}

    private let urlSession = URLSession.shared
    private let baseURL = URL(string: Api.baseURLString)
    private let jsonDecoder = JSONDecoder()

    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {

        urlSession.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    do {
                        let values = try self.jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(.failure(.errorResponse(values)))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }

                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(.serviceError(error)))
            }
        }.resume()
    }

    public func fetchCars(result: @escaping (Result<[Car], NetworkServiceError>) -> Void) {
        guard let url = baseURL?.appendingPathComponent(Endpoint.cars.rawValue) else {
            result(.failure(.invalidUrl))
            return
        }
        fetchResources(url: url, completion: result)
    }

}

public enum NetworkServiceError: Error {
    case errorResponse(_ errorResponse: ErrorResponse)
    case invalidUrl
    case invalidEndpoint
    case invalidResponse
    case decodeError
    case serviceError(_ error: Error) // for exmple device offline, server offline, epmty response or https cert errors.
    // need more information from product owner to implement more detailed handler for these error cases
}
