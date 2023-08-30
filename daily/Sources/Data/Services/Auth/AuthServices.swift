import Foundation
import Moya

enum AuthServices {
    case signIn(param: SignInRequest)
    case signUp(param: SignUpRequest)
    case checkEmail(email: String)
}


extension AuthServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/auth/signin"
        case .signUp:
            return "/auth/signup"
        case .checkEmail:
            return "/auth/email"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .checkEmail:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .signIn(param):
            return .requestJSONEncodable(param)
        case let .signUp(param):
            return .requestJSONEncodable(param)
        case let .checkEmail(email):
            return .requestParameters(
                parameters: ["email" : email],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
