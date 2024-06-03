//
//  Model.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import SwiftyJSON


enum ShopRole:String {
    case sellerIndividual = "seller_individual"
    case sellerLegal = "seller_legal"
    case buyerIndividual = "buyer_individual"
    case buyerLegal = "buyer_legal"
}

struct RatingStruct {
    var rating: Float = 0.0
    var totalVotes: Int = 0
}

struct CommentsStruct {
    var comment: String
    var createdAt: String
    var phoneNumber: String
    var commentsCount: Int
    var author:Author = Author()
}

struct JSONUser {
    var is_seller:Bool?
    var id:Int
    var name:String
    var avatar:String
    var subscribers: Int? = 0
    var subscriptions: Int? = 0
    var posts: Int? = 0
    var phoneNumber: String? = ""
    var shopName: String
}

struct Product {
    var title: String? = ""
    var priceUSD: Int? = 0
    var image: [String]? = [""]
    var productID:Int? 
    var mainImages:String? = ""
    var likes: Int? = 0
    var rating = RatingStruct()
    var viewsCount: Int? = 0
    var commentsCount: Int? = 0
    var sharesCount: Int? = 0
    var description: String? = ""
    var meLike: Bool = false
    var author: Author = Author()
    var comments: [CommentsStruct] = [CommentsStruct]()
}


struct Author {
    var authorId:Int = 0
    var firstName:String = ""
    var avatar: String = ""
}


struct Category {
    var id: Int
    var image: String?
    var name: String
    var parentID: Int
    var subCategories = [Category]()
    
    init(json: JSON) {
        id = json["id"].intValue
        image = json["image_url"].string
        name = json["name"].stringValue
        parentID = json["parent_category_id"].intValue
        
        if let subcategories = json["subcategories"].dictionary {
            subCategories = subcategories.map { Category(json: $0.1) }
        }
    }
}

struct Filter {
    static var search:String?
    static var isAscending: Bool?
    static var isNearby:Bool?
    static var priceOt:Int?
    static var priceDo: Int?
    static var isNegotiable: Bool?
    static var valuta: String?
    static var isNew: Bool?
    static var isSellerVerified:Bool?
    static var opt:Bool?
    static var rasrochka:Bool?
    static var roznica:Bool?
}


enum SegmentInst {
    case instagram
    case multimedia
}


class Constants {
    static let url = "https://api.intop.uz/monolith/"
}


extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}


