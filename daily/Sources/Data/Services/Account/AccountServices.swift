import Foundation
import Moya

enum AccountServices {
    case theme(authorization: String)
    case themeCount(theme: String, authorization: String)
    case accountSetInfo(authorization: String, param: AccountSetInfoRequest)
}


extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .accountSetInfo:
            return "/account/info"
            
        case .theme:
            return "/account/theme"
            
        case .themeCount:
            return "/account/theme-count"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accountSetInfo:
            return .post
            
        case .theme, .themeCount:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .accountSetInfo(_,param):
            return .requestJSONEncodable(param)
            
        case .theme:
            return .requestPlain
            
        case let .themeCount(theme,_):
            return .requestParameters(
                parameters: ["theme" : theme],
                encoding: URLEncoding.queryString
            )
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .theme(authorization),
            let .themeCount(_, authorization), let .accountSetInfo(authorization,_):
            return ["Content-Type" :"application/json", "Authorization": authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
