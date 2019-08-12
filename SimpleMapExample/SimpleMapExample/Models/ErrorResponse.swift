//
//  ErrorResponse.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation

public struct ErrorResponse: Decodable {
    
    // since i have no API documentation lets assume error response has code and message
    let code: Int?
    let message: String?
    
}
