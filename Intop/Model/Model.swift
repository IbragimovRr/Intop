//
//  Model.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation

struct JSONUser: Decodable {
    var isSeller:Bool
    var id:Int
}

struct JSONSign: Decodable {
    var details:String
}

struct JSONCode: Decodable {
    var code: String
    var details:String
}

extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
