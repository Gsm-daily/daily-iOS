//
//  AccountServices.swift
//  Daily
//
//  Created by 선민재 on 2023/08/31.
//  Copyright © 2023 Daily. All rights reserved.
//

import Foundation
import Moya

enum AccountServices {
    case choiceTheme(param: ChoiceThemeRequest, authorization: String)
}


extension AccountServices: TargetType {
    public var baseURL: URL {
        return URL(string: BaseURL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .choiceTheme:
            return  "/account/choice-theme"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .choiceTheme:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .choiceTheme(param, _):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .choiceTheme(_,authorization):
            return ["Content-Type" :"application/json", "Authorization": authorization]
        default:
            return["Content-Type" :"application/json"]
        }
    }
}
