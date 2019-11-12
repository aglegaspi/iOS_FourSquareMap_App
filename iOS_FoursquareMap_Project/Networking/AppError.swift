//
//  AppError.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/12/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
