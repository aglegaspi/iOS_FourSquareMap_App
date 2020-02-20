//
//  Collections.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/2/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import Foundation

struct FSCollection: Codable {
    let collectionUID: String
    var collections: [FSFavorite]
    var collectionName: String
    let collectionImage: String
    var collectionFeedback: String
}


