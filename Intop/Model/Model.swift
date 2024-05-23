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

struct JSONUser {
    var is_seller:Bool?
    var id:Int
    var name:String
    var avatar:String
}

struct Product {
    var title: String?
    var priceUSD: Int?
    var image: [String]?
    var reviews: Int?
    var productID:Int?
    var likes: Int?
    var description: String?
    var author: Author?
}


struct Author {
    var authorId:Int
}

struct Favorites {
    var price:Int
    var mainImage:String
    var title:String
    var tovarId:Int
    var reviews:Int
}

struct Category {
    var image:String
    var name:String
    var subCategories: [SubCategories]
}

struct SubCategories {
    var image:String
    var name:String
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


