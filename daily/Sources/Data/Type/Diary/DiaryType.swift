import Moya

enum DiaryType {
    case writeDiary(param: WriteDiaryRequest, authorization: String)
}


extension DiaryType: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .writeDiary:
            return "/diary"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writeDiary:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .writeDiary(param,_):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .writeDiary(_, authorization):
            return ["Content-Type" :"application/json", "Authorization": authorization]
        }
    }
}
