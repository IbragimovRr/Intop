//
//  Model.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation


enum ShopRole:String {
    case sellerIndividual = "seller_individual"
    case sellerLegal = "seller_legal"
    case buyerIndividual = "buyer_individual"
    case buyerLegal = "buyer_legal"
}

struct RatingStruct {
    var rating: Float
    var totalVotes: Int
}

struct CommentsStruct {
    var comment: String
    var createdAt: String
    var phoneNumber: String
    var commentsCount: Int
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
    var productID:Int
    var mainImages:String? = ""
    var likes: Int? = 0
    var viewsCount: Int? = 0
    var commentsCount: Int? = 0
    var sharesCount: Int? = 0
    var description: String? = ""
    var meLike: Bool = false
    var author: Author = Author()
}


struct Author {
    var authorId:Int = 0
    var firstName:String = ""
    var avatar: String = ""
    
}

struct Favorites {
    var price:Int
    var mainImage:String
    var title:String
    var tovarId:Int
    var reviews:Int
}

struct Category {
    var image:String?
    var name:String
    var subCategories: [Category]?
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


