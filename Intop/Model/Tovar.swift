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
    
    func getTovarById(productId: Int) async throws -> Product{
        let url = Constants.url + "products/\(productId)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        let title = json["title"].stringValue
        let priceUSD = json["price_USD"].intValue
        let description = json["description"].stringValue
        let authorId = json["author"]["id"].intValue
        let firstNameAuthor = json["author"]["first_name"].stringValue
        let avatarAuthor = json["author"]["avatar_url"].stringValue
        let likes = json["likes_count"].intValue
        let imageMain = json["main_image_url"].stringValue
        let viewsCount = json["views_count"].intValue
        let commentsCount = json["comments_count"].intValue
        let sharesCount = json["shares_count"].intValue
        let phoneNumber = json["user_phone_number"].stringValue
        var images = [String]()
        let count = json["additional_images_json"].count
        
        if count != 0 {
            for x in 0...count - 1 {
                let image = json["additional_images_json"][x].stringValue
                images.append(image)
            }
        }
        
        let rating = try await Rating().getRatingByProductId(productId: productId)
        let comments = try await Comments().getCommentsByProductId(limit: 0, productId: productId)

        let author = Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor, phoneNumber: phoneNumber)
        var products = Product(title: title, priceUSD: priceUSD, image: images,  productID: productId, mainImages: imageMain, likes: likes, rating: rating, viewsCount: viewsCount,commentsCount: commentsCount,sharesCount: sharesCount, description: description, author: author, comments: comments)

        
        let meLike = try await checkMeLikeProduct(products)
        products.meLike = meLike
        return products
    }
    
    func checkMeLikeProduct(_ product: Product) async throws -> Bool {
        let result = try await Wishlist().getFavorites()
        var resultBool = false
        for x in result {
            if product.productID == x.productID {
                resultBool = true
            }
        }
        return resultBool
    }
    
    func getAllTovars(limit: Int) async throws -> [Product]{
        let name = "?prod_name=\(Filter.search ?? "")"
        let currency = "&currency=\(Filter.valuta ?? "")"
        let ascending = "&is_ascending=\(boolInString(Filter.isAscending))"
        let limitURL = "&limit=\(limit)"
        let price = "&price_min=\(IntInString(Filter.priceOt))&price_max=\(IntInString(Filter.priceDo))"
        let negotiable = "&is_negotiable=\(boolInString(Filter.isNegotiable))"
        let nearby = "&is_nearby=\(boolInString(Filter.isNearby))"
        let wholesale = "&is_wholesale=\(boolInString(Filter.opt))"
        let installment = "&is_installment=\(boolInString(Filter.rasrochka))"
        let retail = "&is_retail=\(boolInString(Filter.roznica))"
        let new = "&is_new=\(boolInString(Filter.isNew))"
        let sellerVerified = "&is_seller_verified=\(boolInString(Filter.isSellerVerified))"
        let url = Constants.url + "products" + name  + currency + ascending + limitURL + price + negotiable + nearby + wholesale + installment + retail + new + sellerVerified
        print(url)
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        let count = json.count
        print(count)
        guard count != 0 else {return [Product]()}
        var products = [Product]()
        for x in 0...count - 1 {
            let id = json[x]["product_id"].intValue
            let title = json[x]["title"].stringValue
            let priceUSD = json[x]["price_USD"].intValue
            let description = json[x]["description"].stringValue
            let authorId = json[x]["author"]["id"].intValue
            let firstNameAuthor = json[x]["author"]["first_name"].stringValue
            let avatarAuthor = json[x]["author"]["avatar_url"].stringValue
            let likes = json[x]["likes_count"].intValue
            let imageMain = json[x]["main_image_url"].stringValue
            let viewsCount = json[x]["views_count"].intValue
            let commentsCount = json[x]["comments_count"].intValue
            let phoneNumber = json[x]["user_phone_number"].stringValue
            let product = Product(title: title, priceUSD: priceUSD, productID: id, mainImages: imageMain, likes: likes, viewsCount: viewsCount, commentsCount: commentsCount, description: description, author: Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor, phoneNumber: phoneNumber))
            
            products.append(product)
        }
        return products
    }
    
    func getTovarByUserId(_ phoneNumber: String,limit:Int) async throws -> [Product]{
        let url = Constants.url + "products?user_phone_number=\(phoneNumber)&limit=\(limit)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        let count = json.count
        
        var productsArray = [Product]()
        guard count != 0 else {return [Product]()}
        for x in 0...count - 1 {
            let likes = json[x]["likes_count"].intValue
            let viewsCount = json[x]["views_count"].intValue
            let imageMain = json[x]["main_image_url"].stringValue
            let sharesCount = json[x]["shares_count"].intValue
            let commentsCount = json[x]["comments_count"].intValue
            let productID = json[x]["product_id"].intValue
            let title = json[x]["title"].stringValue
            print(viewsCount,title)
            let products = Product(title: title, productID: productID, mainImages:imageMain, likes: likes, viewsCount: viewsCount, commentsCount: commentsCount, sharesCount: sharesCount)
            productsArray.append(products)
        }
        return productsArray
    }
    
    

    
}

extension Tovar {
    private func boolInString(_ bool: Bool?) -> String {
        if bool == nil {
            return ""
        }else {
            return "\(bool!)"
        }
    }
    
    private func IntInString(_ int: Int?) -> String {
        if int == nil {
            return ""
        }else {
            return "\(int!)"
        }
    }
}
