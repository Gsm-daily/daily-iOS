import Foundation

struct AccountSetInfoModel: Codable {
    let data: AccountSetInfoResponse
}

struct AccountSetInfoResponse: Codable {
    let name: String
    let theme: String
}
