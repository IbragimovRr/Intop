//
//  Tovar.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 23.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Tovar {
    func getTovarById(productId: Int, completion: @escaping (_ result: Product) -> ()) {
        let url = Constants.url + "products/\(productId)"
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
                
            case .success(let value):
                let json = JSON(value)
                let title = json["title"].stringValue
                let priceUSD = json["price_USD"].intValue
                let reviews = json["reviews"].intValue
                let description = json["description"].stringValue
                let authorId = json["author"]["id"].intValue
                let firstNameAuthor = json["author"]["first_name"].stringValue
                let avatarAuthor = json["author"]["avatar_url"].stringValue
                var images = [String]()
                for x in 0...json["images"].count - 1 {
                    let image = json["images"][x]["cloud_link"].stringValue
                    images.append(image)
                }
                
                let author = Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor)
                let products = Product(title: title, priceUSD: priceUSD, image: images, reviews: reviews, description: description, author: author)
                completion(products)
            case .failure(_):
                print("error")
            }
        }
    }
    
    func getAllTovars(completion:@escaping ([Product]) -> ()) {
        let url = Constants.url + "products"
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
                
            case .success(let value):
                let json = JSON(value)
                var products = [Product]()
                for x in 0...json.count - 1 {
                    let title = json[x]["title"].stringValue
                    let price = json[x]["price"].intValue
                    let image = json[x]["main_image_url"].stringValue
                    let id = json[x]["product_id"].intValue
                    let likes = json[x]["likes_count"].intValue
                    let product = Product(title: title, priceUSD: price, image: [image], productID: id, likes: likes)
                    products.append(product)
                }
                completion(products)
            case .failure(_):
                print("")
            }
        }
    }
    
}
