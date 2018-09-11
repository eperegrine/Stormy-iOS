//
//  Location.swift
//  Stormy
//
//  Created by Emily Peregrine on 11/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}

extension Coordinate {
    static var alcatraz: Coordinate {
        return Coordinate(latitude: 37.8267, longitude: -122.4233)
    }
}
