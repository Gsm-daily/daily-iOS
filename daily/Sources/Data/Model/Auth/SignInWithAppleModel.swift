import Foundation

struct SignInWithAppleModel: Codable {
    let data: SignInWithAppleResponse
}

struct SignInWithAppleResponse: Codable {
    let accessToken: String
    let accessTokenExpiredAt: String
    let isExist: Bool
    let refreshToken: String
    let refreshTokenExpiredAt: String
}
