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

struct JSONUser: Decodable {
    var is_seller:Bool = false
    var id:Int
}

struct JSONSign: Decodable {
    var details:String
}

struct JSONCode: Decodable {
    var code: String
    var details:String
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

