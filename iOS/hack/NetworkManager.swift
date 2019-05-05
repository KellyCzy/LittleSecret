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
let friendsPost = "http://34.74.44.203/friend/posts/"
let myPost = "http://34.74.44.203/posts/"

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

    
    static func getFriendRequestList(user_id: Int, completion: @escaping (Friends) -> Void) {
        Alamofire.request("http://34.74.44.203/friend/request/list/\(user_id)/", method: .get).validate().responseData { (response) in
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

    static func addFriend(user_id: Int, requester_id: Int, completion:@escaping (FriendRequest?) -> Void){
        let parameters: [String: Any] = [
            "user_id" : user_id,
            "requester_id": requester_id,
        ]
        Alamofire.request("http://34.74.44.203/friend/accept/\(requester_id)/\(user_id)/", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let friendRequest = try? jsonDecoder.decode(FriendRequest.self, from: data) {
                completion(friendRequest)
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
    
    static func sendRequest(user_id: Int, requested_email: String, completion:@escaping (FriendRequest?) -> Void){
        let parameters: [String: Any] = [
            "user_id" : user_id,
            "requested_email": requested_email,
            ]
        Alamofire.request("http://34.74.44.203/friend/request/\(user_id)/\(requested_email)/", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let friendRequest = try? jsonDecoder.decode(FriendRequest.self, from: data) {
                completion(friendRequest)
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
    static func createPost(user: Int, text:String, completion:@escaping (FriendData?) -> Void){
        let parameters: [String: Any] = [
            "text": text,
            ]
        Alamofire.request("http://34.74.44.203/posts/\(MyVariables.user_id ?? -1)/", method: .post,parameters: parameters, encoding: JSONEncoding.default).validate().responseData{(response) in switch response.result{
        case .success(let data):
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print(json)
            }
            let jsonDecoder = JSONDecoder()
            if let Post = try? jsonDecoder.decode(CreatePostBackend.self, from: data) {
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
    
    static func myPosts(user:Int, completion: @escaping ([FriendData]?)-> Void){
        guard let userId = MyVariables.user_id else {
            completion(nil)
            return
        }
        let friendsPostURLString = "\(myPost)\(userId)/"
        Alamofire.request(friendsPostURLString, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let postArray = try? jsonDecoder.decode(PostArrayBackend.self, from: data) {
                    completion(postArray.data)
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
    
    static func friendPosts(user:Int, completion: @escaping ([FriendData]?) -> Void) {
        guard let userId = MyVariables.user_id else {
            completion(nil)
            return
        }
        let friendsPostURLString = "\(friendsPost)\(userId)/"
        Alamofire.request(friendsPostURLString, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let postArray = try? jsonDecoder.decode(PostArrayBackend.self, from: data) {
                    completion(postArray.data)
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
    
}

