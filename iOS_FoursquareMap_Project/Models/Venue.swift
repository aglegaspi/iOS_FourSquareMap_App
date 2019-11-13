import MapKit
import CoreLocation
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
    
    // DECODES JSON DATA FROM API CALL
    static func getVenues(from data: Data) throws -> [Venue]? {
        do {
            let response = try JSONDecoder().decode(VenueWrapper.self,from: data)
            return response.response?.venues
        } catch {
            return nil
        }
    }
  
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
