import Foundation
import Moya

enum AccountServices {
    case choiceTheme(param: ChoiceThemeRequest, authorization: String)
    case theme(authorization: String)
}


extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .choiceTheme:
            return "/account/choice-theme"
        case .theme:
            return "/account/theme"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .choiceTheme:
            return .post
        case .theme:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .choiceTheme(param, _):
            return .requestJSONEncodable(param)
        case .theme:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .choiceTheme(_,authorization), let .theme(authorization):
            return ["Content-Type" :"application/json", "Authorization": authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
