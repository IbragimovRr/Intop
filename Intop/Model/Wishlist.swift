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
    
    
    func getFavorites(completion: @escaping (_ result:[Favorites]) -> ()) {
        User().getInfoUser(User.phoneNumber) { info in
            let id = "8132"
            let url = Constants.url + "favorites/products/\(id)?limit=10"
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let count = json.count
                    var arrayFavorites = [Favorites]()
                    for x in 0...count - 1 {
                        let title = json[x]["title"].stringValue
                        let tovarId = json[x]["id"].intValue
                        let mainImage = json[x]["main_image_url"].stringValue
                        let price = json[x]["price"].intValue
                        let reviews = json[x]["reviews"].intValue
                        let favorites = Favorites(price: price, mainImage: mainImage, title: title, tovarId: tovarId, reviews: reviews)
                        arrayFavorites.append(favorites)
                    }
                    completion(arrayFavorites)
                    print(arrayFavorites)
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
