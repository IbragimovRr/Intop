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
                let author = Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor)
                let products = Product(title: title, priceUSD: priceUSD, reviews: reviews, description: description, author: author)
                completion(products)
            case .failure(_):
                print("error")
            }
        }
    }
}
