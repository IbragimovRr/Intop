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
                let imageMain = json["main_image_url"].stringValue
                var images = [String]()
                let count = json["additional_images_json"].count
                
                if count != 0 {
                    for x in 0...count - 1 {
                        let image = json["additional_images_json"][x].stringValue
                        images.append(image)
                    }
                }
                let author = Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor)
                var products = Product(title: title, priceUSD: priceUSD, image: images, reviews: reviews, productID: productId, mainImages: imageMain, likes: likes, description: description, author: author)
                
                self.checkMeLikeProduct(products) { meLike in
                    products.meLike = meLike
                    completion(products)
                }
            case .failure(_):
                print("error")
            }
        }
    }
    
    func checkMeLikeProduct(_ product: Product, completion:@escaping (_ meLike:Bool) -> ()) {
        Wishlist().getFavorites { result in
            var resultBool = false
            for x in result {
                if product.productID == x.tovarId {
                    resultBool = true
                }
            }
            completion(resultBool)
        }
    }
    
    func getAllTovars(completion:@escaping ([Product]) -> ()) {
        let url = Constants.url + "products"
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                let count = json.count
                guard count != 0 else {return}
                var products = [Product]()
                for x in 0...count - 1 {
                    let id = json[x]["product_id"].intValue
                    self.getTovarById(productId: id) { product in
                        let product = Product(title: product.title, priceUSD: product.priceUSD, productID: id, mainImages: product.mainImages,likes: product.likes, meLike: product.meLike, author: product.author)
                        products.append(product)
                        if x == count - 1{ completion(products) }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
