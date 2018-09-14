//
//  DarkSkyError.swift
//  Stormy
//
//  Created by Emily Peregrine on 11/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
    case requestFailed
    case responseUnnsucceful(satusCode: Int)
    case invalidData
    case jsonParsingError
    case invalidURL
    case unkownError
}
