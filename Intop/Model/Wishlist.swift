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
    
    
    func getFavorites() async throws -> [Product] {
        let info = try await User().getInfoUser(User.phoneNumber)
        let id = info.id
        let url = Constants.url + "likes/products/\(id)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        let count = json.count
        guard count != 0 else { return [Product]()}
        var arrayFavorites = [Product]()
        for x in 0...count - 1 {
            let title = json[x]["title"].stringValue
            let mainImage = json[x]["main_image_url"].stringValue
            let price = json[x]["price"].intValue
            let productID = json[x]["id"].intValue
            let rating = try await Rating().getRatingByProductId(productId: productID)
            let favorites = Product(title: title,priceUSD: price, productID: productID, mainImages: mainImage, rating: rating)
            arrayFavorites.append(favorites)
        }
        return arrayFavorites
    }
    
    func getFavoritesByID(_ productID:Int) async throws -> Int {
        let url = Constants.url + "likes_count/\(productID)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        let likesCount = json["likes_count"].intValue
        return likesCount
    }
    
    func addFavorites(_ product: Product, method:HTTPMethod) async throws {
        let info = try await User().getInfoUser(User.phoneNumber)
        let id = info.id
        let url = Constants.url + "likes"
        let parameters = [
            "user_id": id,
            "product_id": product.productID
        ]
        let _ = try await AF.request(url, method: method, parameters: parameters,encoding: JSONEncoding.default, headers: self.headers).serializingData().value
    }
}
