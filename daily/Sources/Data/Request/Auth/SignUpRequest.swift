//
//  SignUpRequest.swift
//  Daily
//
//  Created by 선민재 on 2023/08/30.
//  Copyright © 2023 Daily. All rights reserved.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let password: String
    let name: String
    
    init(email: String, password: String, name: String) {
        self.email = email
        self.password = password
        self.name = name
    }
}
