//
//  ImageHelper.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 11/13/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    static let shared = ImageHelper()
    
    private init() {}
    
    func convertToUIImage(urlStr: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        guard let url = URL(string: urlStr) else { completionHandler(.failure(.badURL)); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else { completionHandler(.failure(.noDataReceived)); return }
            guard let data = data else { completionHandler(.failure(.noDataReceived)); return }
            guard let image = UIImage(data: data) else { completionHandler(.failure(.notAnImage)); return }
            completionHandler(.success(image))
        } .resume()
        
    }
    
}
