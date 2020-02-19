import Foundation

struct ResultWrapper: Codable {
    let response: ImageResponse?
}

// MARK: - Response
struct ImageResponse: Codable {
    let photos: PhotoWrapper?
}

// MARK: - Photos
struct PhotoWrapper: Codable {
    let items: [VenuePhoto]
}

// MARK: - Item
struct VenuePhoto: Codable {
    let itemPrefix: String
    let suffix: String
    let width, height: Int

    enum CodingKeys: String, CodingKey {
        case itemPrefix = "prefix"
        case suffix, width, height
    }
    
    static func getPhoto(from jsonData: Data) -> VenuePhoto? {
        do {
            let data = try JSONDecoder().decode(ResultWrapper.self, from: jsonData)
            return data.response?.photos?.items.first
        } catch {
            print("Decoding error: \(error)")
            return VenuePhoto(itemPrefix: "https://igx.4sqi.net/img/general", suffix: "/5163668_xXFcZo7sU8aa1ZMhiQ2kIP7NllD48m7qsSwr1mJnFj4.jpg", width: 300, height: 500)
        }
    }
    
    func getVenueImage() -> String {
        return "\(itemPrefix)\(String(width))x\(String(height))\(suffix)"
    }
    
}
