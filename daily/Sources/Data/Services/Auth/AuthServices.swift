import Foundation
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
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
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
