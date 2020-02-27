//
//  VenueAPIHelper.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/12/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import Foundation

struct VenueAPIHelper {
    private let apikey = Secrets.apikey
    private let secretkey = Secrets.secretkey
    
    static let manager = VenueAPIHelper()
    
    func getVenues(query: String, lat: Double, long: Double, completion: @escaping (Result<[Venue]?, AppError>) -> Void) {
        let urlString = "https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&client_id=\(apikey)&client_secret=\(secretkey)&query=\(query)&v=20191104&limit=2"
        
        guard let url = URL(string: urlString) else { fatalError() }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            
            switch result {
            case let .success(data):
                do {
                    let venuesFromOnline = try Venue.getVenues(from: data)
                    completion(.success(venuesFromOnline))
                } catch {
                    completion(.failure(.couldNotParseJSON(rawError: error)))
                }
            case let .failure(error):
                completion(.failure(error))
                return
            }
        }
    }
}

