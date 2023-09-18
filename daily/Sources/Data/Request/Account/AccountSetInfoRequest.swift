import Foundation

struct AccountSetInfoRequest: Codable {
    let name: String
    let theme: String
    
    init(name: String, theme: String) {
        self.name = name
        self.theme = theme
    }
}
