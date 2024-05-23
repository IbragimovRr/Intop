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
                let likes = json["likes_count"].intValue
                var images = [String]()
                let count = json["additional_images_json"].count
                if count != 0 {
                    for x in 0...count - 1 {
                        let image = json["additional_images_json"][x].stringValue
                        images.append(image)
                    }
                }
                let author = Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor)
                let products = Product(title: title, priceUSD: priceUSD, image: images, reviews: reviews, likes: likes, description: description, author: author)
                print(products)
                completion(products)
            case .failure(_):
                print("error")
            }
        }
    }
    
    func getAllTovars(completion:@escaping (Product) -> ()) {
        let url = Constants.url + "products"
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
                
            case .success(let value):
                let json = JSON(value)
                for x in 0...json.count - 1 {
                    let id = json[x]["product_id"].intValue
                    self.getTovarById(productId: id) { product in
                        let product = Product(title: product.title, priceUSD: product.priceUSD, image: product.image, productID: id, likes: product.likes, author: product.author)
                        completion(product)
                    }
                }
            case .failure(_):
                print("")
            }
        }
    }
    
}
