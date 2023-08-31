import Foundation

struct ChoiceThemeRequest: Codable {
    let theme: String
    
    init(theme: String) {
        self.theme = theme
    }
}
