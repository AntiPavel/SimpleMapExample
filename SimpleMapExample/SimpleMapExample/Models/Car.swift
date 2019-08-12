//
//  Car.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
import CoreLocation

public struct Car: Decodable {

    // swiftlint:disable identifier_name
    var id: String
    var modelIdentifier: String
    var modelName: String
    var name: String
    var make: String
    var group: String
    var color: String
    var series: String
    var fuelType: String
    var fuelLevel: Double
    var transmission: String
    var licensePlate: String
    var latitude: Double
    var longitude: Double
    var innerCleanliness: String?
    var carImageUrl: String?

}

public extension Car {

    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var transmissionType: TransmissionType? {
        return TransmissionType(rawValue: transmission)
    }

    // here should be more computed properties wrapped to enums for sefety but i have no DB documentation
    // since I have no DB details I'm not sure if i know all the used modelIdentifiers, series, fuelTypes, groups, cleanlinesses and other
}

public enum TransmissionType: String {
    case automatic = "A"
    case mechanic = "M"

}
