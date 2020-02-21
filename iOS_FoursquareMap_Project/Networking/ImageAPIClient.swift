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
    
    func getVenueImageURL(venueID: String, completionHandler: @escaping (Result<String, AppError>) -> ()) {
        let urlStr = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(apikey)&client_secret=\(secretkey)&v=20191104&limit=1"
        
        guard let url = URL(string: urlStr) else { completionHandler(.failure(AppError.badURL))
            return }
        
        print(url)
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
                
            case .success(let data):
                guard let photoInfo = VenuePhoto.getPhoto(from: data) else { return }
                let imageString = "\(photoInfo.itemPrefix)\(String(photoInfo.width))x\(String(photoInfo.height))\(photoInfo.suffix)"
                completionHandler(.success(imageString))
                
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
                
            }
        }
    }

}

