import Foundation

struct ThemeRequest: Codable {
    let theme: [String]
    
    init(theme: [String]) {
        self.theme = theme
    }
}
