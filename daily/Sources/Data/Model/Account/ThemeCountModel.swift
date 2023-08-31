import Foundation

struct ThemeCountModel: Codable {
    let data: ThemeCountResponse
}

struct ThemeCountResponse: Codable {
    let count: Int
}
