//
//  Request.swift
//  hack
//
//  Created by Chengyin Tan on 5/5/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation

struct FriendRequest: Codable {
    
    var requester: Int
    var requested: Int
    var action_user: Int
    var status: String
    
}
