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
            let id = info.id
            let url = Constants.url + "likes/products/\(id)"
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let count = json.count
                    guard count != 0 else {completion([]); return}
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
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    
    func getFavoritesByID(_ productID:Int, completion: @escaping (_ likesCount:Int) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let url = Constants.url + "likes_count/\(productID)"
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let likesCount = json["likes_count"].intValue
                    completion(likesCount)
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    
    func addFavorites(_ product: Product, method:HTTPMethod,completion: (() -> ())?){
        User().getInfoUser(User.phoneNumber) { info in
            let id = info.id
            let url = Constants.url + "likes"
            let parameters = [
                "user_id": id,
                "product_id": product.productID
            ]
            AF.request(url, method: method, parameters: parameters,encoding: JSONEncoding.default, headers: self.headers).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    completion?()
                case .failure(_):
                    print("Oшибка")
                }
            }
        }
    }
}
