//
//  Comments.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 25.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Comments {
    
    func getCommentsByProductId(limit: Int, productId: Int) async throws -> [CommentsStruct]{
        let url = Constants.url + "comments/\(productId)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        var arrayComments = [CommentsStruct]()
        let count = json.count
        guard count != 0 else {return [CommentsStruct]()}
        
        for x in 0...count - 1{
            let comment = json[x]["text"].stringValue
            let createdAt = json[x]["created_at"].stringValue
            let phoneNumber = json[x]["user_phone_number"].stringValue
            let comments = CommentsStruct(comment: comment, createdAt: createdAt, phoneNumber: phoneNumber)
            arrayComments.append(comments)
            if x == limit && limit != 0 {
                return arrayComments
            }
        }
        
        return arrayComments
    }
    
    func postComment(productId: Int, phoneNumber: String, text: String) async throws {
        let url = Constants.url + "comments"
        let parameters = [
            "product_id": productId,
            "user_phone_number":phoneNumber,
            "text":text
        ] as [String : Any]
        let value = try await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).serializingData().value
        
        
    }
    
}
