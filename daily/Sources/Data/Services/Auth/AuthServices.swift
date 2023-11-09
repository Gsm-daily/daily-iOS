import Moya

enum AuthServices {
    case signInWithApple(identityToken: String)
}


extension AuthServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case let .signInWithApple(identityToken):
            return "/auth/signin/apple/\(identityToken)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signInWithApple:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signInWithApple:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return["Content-Type" :"application/json"]
        }
    }
}

extension AuthServices {
    var sampleData: Data {
        switch self {
        case let .signInWithApple(identityToken):
            Data(
                """
                    "accessToken": "string",
                    "accessTokenExpiredAt": "2023-11-09T14:21:23.074Z",
                    "isExist": true,
                    "refreshToken": "string",
                    "refreshTokenExpiredAt": "2023-11-09T14:21:23.074Z"
                """.utf8
            )
        }
    }
}
