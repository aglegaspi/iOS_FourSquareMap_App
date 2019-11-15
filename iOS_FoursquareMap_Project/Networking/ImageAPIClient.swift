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
    
    func getPictureURL(venueID: String, completionHandler: @escaping (Result<Image, AppError>) -> ()) {
        let urlStr = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(apikey)&client_secret=\(secretkey)&v=20191104&limit=1"
        
        guard let url = URL(string: urlStr) else { completionHandler(.failure(AppError.badURL))
            return }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .success(let data):
                let photoInfo = Image.getPhoto(from: data)
                completionHandler(.success(photoInfo!))
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
                
            }
        }
    }

}

