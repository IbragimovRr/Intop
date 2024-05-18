//
//  Wishlist.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 18.05.2024.
//

import Foundation
import Alamofire

class Wishlist {
    func getFavorites() {
        User().getInfoUser(User.phoneNumber) { info in
            let id = info.id
            let url = Constants.url + "products/8132?limit=10"
            AF.request(url, method: .get).responseString { responseData in
                switch responseData.result {
                case .success(let value):
                    print(value)
                case .failure(_):
                    print("error")
                    
                }
            
            }
        }
    }
    func addFavorites() {
        
    }
}
