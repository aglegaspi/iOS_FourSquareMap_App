//
//  ImageAPIHelper.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/13/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import Foundation

struct ImageAPIHelper {
    private let apikey = Secrets.apikey
    private let secretkey = Secrets.secretkey
    
    static let manager = ImageAPIHelper()
    
    func getVenueImageURL(venueID: String, completionHandler: @escaping (Result<VenuePhoto, AppError>) -> ()) {
        let urlStr = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(apikey)&client_secret=\(secretkey)&v=20191104&limit=1"
        
        guard let url = URL(string: urlStr) else { completionHandler(.failure(AppError.badURL))
            return }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .success(let data):
                let photoInfo = VenuePhoto.getPhoto(from: data)
                completionHandler(.success(photoInfo ?? VenuePhoto(itemPrefix: "https://igx.4sqi.net/img/general", suffix: "/5163668_xXFcZo7sU8aa1ZMhiQ2kIP7NllD48m7qsSwr1mJnFj4.jpg", width: 300, height: 500)))
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
                
            }
        }
    }

}

