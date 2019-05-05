//
//  PostBackend.swift
//  hack
//
//  Created by 紫瑶 程 on 5/4/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation

//----------------New---------------------
struct PostBackend: Codable {
    
     var success: Bool
     var data: Data
    
}


struct Data: Codable {
    var id: Int
    var text: String?
    var comments: [String]
}


