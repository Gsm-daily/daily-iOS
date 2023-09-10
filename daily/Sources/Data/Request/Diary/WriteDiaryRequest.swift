import Foundation

struct WriteDiaryRequest: Codable {
    let content: String
    let date: String
    
    init(content: String, date: String) {
        self.content = content
        self.date = date
    }
}
