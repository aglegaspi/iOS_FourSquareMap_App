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
    let items: [Image]?
}

// MARK: - Item
struct Image: Codable {
    let itemPrefix: String?
    let suffix: String?
    let width, height: Int?

    enum CodingKeys: String, CodingKey {
        case itemPrefix = "prefix"
        case suffix, width, height
    }
    
    static func getPhoto(from jsonData: Data) -> [Image]? {
        do {
            let data = try JSONDecoder().decode(ResultWrapper.self, from: jsonData)
            return data.response?.photos?.items
        } catch {
            print("Decoding error: \(error)")
            return [Image]()
        }
    }
    
}
