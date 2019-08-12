//
//  Api.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation

// the file supposed to be used to switch between prod, dev, and test environment
// for example set RUNTIME_ENV flags like: USE_PRODUCTION_RESOURCES, USE_TEST_RESOURCES, USE_INTEGRATION_RESOURCES and so on
// then use correct configuration:
//
//  #if USE_PRODUCTION_RESOURCES
//  baseURLString = Api.baseURLString
//  #elseif USE_STAGING_RESOURCES
//  baseURLString = StageApi.baseURLString
//  #elseif USE_INT_RESOURCES
//  baseURLString = IntApi.baseURLString
//  #elseif USE_TEST_RESOURCES
//  baseURLString = TestApi.baseURLString
//  #endif

enum Api {
    static let baseURLString = "https://cdn.sixt.io/codingtask"
}
