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
    func addFavorites() {
        
    }
    

}
