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
                let viewsCount = json["views_count"].intValue
                let commentsCount = json["comments_count"].intValue
                let sharesCount = json["shares_count"].intValue
                var images = [String]()
                let count = json["additional_images_json"].count
                
                if count != 0 {
                    for x in 0...count - 1 {
                        let image = json["additional_images_json"][x].stringValue
                        images.append(image)
                    }
                }
                let author = Author(authorId: authorId, firstName: firstNameAuthor, avatar: avatarAuthor)
                var products = Product(title: title, priceUSD: priceUSD, image: images,  productID: productId, mainImages: imageMain, likes: likes, viewsCount: viewsCount,commentsCount: commentsCount,sharesCount: sharesCount, description: description, author: author)
                
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
                if product.productID == x.productID {
                    resultBool = true
                }
            }
            completion(resultBool)
        }
    }
    
    func getAllTovars(completion:@escaping ([Product]) -> ()) {
        let name = "?prod_name=\(Filter.search ?? "")"
        let currency = "&currency=\(Filter.valuta ?? "")"
        let ascending = "&is_ascending=\(boolInString(Filter.isAscending))"
        let price = "&price_min=\(IntInString(Filter.priceOt) )&price_max=\(IntInString(Filter.priceDo))"
        let negotiable = "&is_negotiable=\(boolInString(Filter.isNegotiable))"
        let nearby = "&is_nearby=\(boolInString(Filter.isNearby))"
        let wholesale = "&is_wholesale=\(boolInString(Filter.opt))"
        let installment = "&is_installment=\(boolInString(Filter.rasrochka))"
        let retail = "&is_retail=\(boolInString(Filter.roznica))"
        let new = "&is_new=\(boolInString(Filter.isNew))"
        let sellerVerified = "&is_seller_verified=\(boolInString(Filter.isSellerVerified))"
        let url = Constants.url + "products" + name  + currency + ascending + price + negotiable + nearby + wholesale + installment + retail + new + sellerVerified
        print(url)
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
                        let product = Product(title: product.title, priceUSD: product.priceUSD, productID: id, mainImages: product.mainImages, likes: product.likes,viewsCount: product.viewsCount,commentsCount: product.commentsCount,sharesCount: product.sharesCount,  meLike: product.meLike, author: product.author)
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
