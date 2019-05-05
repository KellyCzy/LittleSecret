//
//  NetworkManager.swift
//  hack
//
//  Created by 紫瑶 程 on 4/29/19.
//  Copyright © 2019 Chengyin Tan. All rights reserved.
//

import Foundation
import Alamofire

let loginEndpoint = "http://34.74.44.203/login/"
let addFriendEndpoint = "http://34.74.44.203/friend/request/"
let postEndpoint = "http://34.74.44.203/post/"
let registerEndpoint = "http://34.74.44.203/register/"
let id = Int(TabBarViewController().idNumber ?? "2")

class NetworkManager {
    
    static func login(email: String, password: String, completion: @escaping (User?) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        Alamofire.request(loginEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let user = try? jsonDecoder.decode(User.self, from: data) {
                    completion(user)
                } else {
                    print("Invalid Response Data")
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    static func register(email: String, password: String, completion: @escaping (User?) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        Alamofire.request(registerEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let user = try? jsonDecoder.decode(User.self, from: data) {
                    completion(user)
                } else {
                    print("Invalid Response Data")
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    static func getFriendList(user_id: Int, completion: @escaping (Friends) -> Void) {
        Alamofire.request("http://34.74.44.203/friend/list/\(user_id)/", method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let friends = try? jsonDecoder.decode(Friends.self, from: data) {
                    print(friends)
                    completion(friends)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


    static func addFriend(user: Int, email:String, completion:@escaping (User?) -> Void){
        let parameters: [String: Any] = [
            "user_id" : user,
            "email": email,
        ]
        Alamofire.request(addFriendEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let user = try? jsonDecoder.decode(User.self, from: data) {
                completion(user)
            } else {
                print("Invalid Response Data")
                completion(nil)
            }
        case .failure(let error):
            print(error.localizedDescription)
            completion(nil)
        }
    }
  
}
    //------------------------------New---------------------------------
    static func createPost(completion:@escaping (Data?) -> Void){
        Alamofire.request("http://34.74.44.203/post/\(id ?? -1)/", method: .post, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let Post = try? jsonDecoder.decode(PostBackend.self, from: data) {
                completion(Post.data)
            } else {
                print("Invalid Response Data")
                completion(nil)
            }
        case .failure(let error):
            print(error.localizedDescription)
            completion(nil)
            }
        }
        //------------------------------------------------------------
    }
}

