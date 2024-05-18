//
//  Wishlist.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 18.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Wishlist {
    
    private let headers:HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    
    func getFavorites() {
        User().getInfoUser(User.phoneNumber) { info in
            let id = info.id
            let url = Constants.url + "favorites/products/8132?limit=10"
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json[0]["description"].stringValue)
                case .failure(_):
                    print("error")
                    
                }
                
            }
        }
    }
    func addFavorites(product: String){
        User().getInfoUser(User.phoneNumber) { info in
            let id = "8132"
            let url = Constants.url + "favorites"
            let parameters = [
                "user_id": id,
                "product_id": product
            ]
            AF.request(url, method: .post, parameters: parameters, headers: self.headers).response { responseData in
                switch responseData.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    let result = json["details"].stringValue
                        
                case .failure(_):
                    print("Oшибка")
                }
                
                
                
                
                
            }
        }
    }
}
