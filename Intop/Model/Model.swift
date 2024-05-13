//
//  Model.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation

struct JSONSign: Decodable {
    var details:String
}

struct JSONCode: Decodable {
    var code: String
    var details:String
}
