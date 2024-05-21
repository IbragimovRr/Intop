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
    
    
    func getFavorites(completion: @escaping (_ result:Favorites) -> ()) {
        User().getInfoUser(User.phoneNumber) { info in
            let id = "8132"
            let url = Constants.url + "favorites/products/\(id)?limit=10"
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let title = json[0]["title"].stringValue
                    let tovarId = json[0]["id"].intValue
                    let mainImage = json[0]["main_image_url"].stringValue
                    let favorites = Favorites(mainImage: mainImage, title: title, id: tovarId)
                    completion(favorites)
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    func addFavorites(product: String, id: String){
        User().getInfoUser(User.phoneNumber) { info in
            let id = info.id
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
