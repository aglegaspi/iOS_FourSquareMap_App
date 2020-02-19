//
//  CollectionPersistenceHelper.swift
//  iOS_FoursquareMap_Project
//
//  Created by Alex 6.1 on 2/2/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import Foundation

struct CollectionPersistenceHelper {
    static let manager = CollectionPersistenceHelper()
    
    func save(entry: FSCollection) throws {
        try persistenceHelper.save(newElement: entry)
    }
    
    func getEntries() throws -> [FSCollection] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteFavorite(with collectionName: String) throws {
        do {
            let entries = try getEntries()
            let newEntries = entries.filter {$0.collectionName != collectionName }
            try persistenceHelper.replace(elements: newEntries)
        }
    }
    
    func editEntry(editEntry: FSCollection, index: Int) throws {
        do {
            try persistenceHelper.update(updatedElement: editEntry, index: index)
        } catch {
            print(error)
        }
        
    }
    private let persistenceHelper = PersistenceHelper<FSCollection>(fileName: "venueCollection.plist")
    
    private init() {}
}
