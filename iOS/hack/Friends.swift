//
//  Friend.swift
//  hack
//
//  Created by Chengyin Tan on 5/4/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation

struct Friends: Codable {
    var friends: [Friend]
}


struct Friend: Codable {
    
    var id: Int
    var email: String
}
