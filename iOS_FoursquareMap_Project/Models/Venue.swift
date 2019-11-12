//
//  Venue.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/11/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import Foundation

// MARK: - VenueWrapper
struct VenueWrapper: Codable {
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String?
    let primary: Bool?
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let distance: Int?
    let postalCode, cc, city, state: String?
    let country: String?
    let formattedAddress: [String]?
}
