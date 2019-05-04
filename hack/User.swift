//
//  User.swift
//  hack
//
//  Created by 紫瑶 程 on 5/1/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var session_token: String
    var session_expiration: String
    var update_token: String
    var user_id: Int
}
