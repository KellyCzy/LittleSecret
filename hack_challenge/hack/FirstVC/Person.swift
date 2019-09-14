//
//  Person.swift
//  hack
//
//  Created by 紫瑶 程 on 4/20/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation
import UIKit

class Person {
    
    //var name: String
    var email: String
    var id: Int
    var image: String
    

    init(id:Int, email:String, image: String) {
        self.id = id
        self.email = email
        self.image = image
    }
}
