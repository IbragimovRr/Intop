//
//  User.swift
//  Intop
//
//  Created by Руслан on 16.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    static var phoneNumber:String {
        get {
            return UD().getPhone() ?? ""
        }
    }
    
    func getInfoUser(_ phoneNumber:String, completion:@escaping (_ info:JSONUser) -> ()) {
        let url = Constants.url + "users/\(phoneNumber)"
        
        AF.request(url).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                let seller = json["is_seller"].boolValue
                let id = json["id"].intValue
                let name = json["first_name"].stringValue
                let avatar = json["avatar_url"].stringValue
                let subscriptions = json["subscriptions_count"].intValue
                let subscribers = json["subscribers_count"].intValue
                let posts = json["products_count"].intValue
                let phoneNumber = json["user_phone_number"].stringValue
                let shopName = json["shop_name"].stringValue
                let jsonUser = JSONUser(is_seller: seller, id: id, name: name, avatar: avatar, subscribers: subscribers,subscriptions: subscriptions, posts: posts, phoneNumber: phoneNumber, shopName: shopName)
                completion(jsonUser)
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func getInfoUserById(_ userId:String, completion:@escaping (_ info:JSONUser) -> ()) {
        var url = Constants.url + "users/id/\(userId)"
        
        AF.request(url).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                let seller = json["is_seller"].boolValue
                let id = json["id"].intValue
                let name = json["first_name"].stringValue
                let avatar = json["avatar_url"].stringValue
                let subscriptions = json["subscriptions_count"].intValue
                let subscribers = json["subscribers_count"].intValue
                let posts = json["products_count"].intValue
                let shopName = json["shop_name"].stringValue
                var jsonUser = JSONUser(is_seller: seller, id: id, name: name, avatar: avatar, subscribers: subscribers, subscriptions: subscriptions, posts: posts, shopName: shopName)
                completion(jsonUser)
            case .failure(_):
                print("Error")
            }
        }
    }
    
    
    
}
