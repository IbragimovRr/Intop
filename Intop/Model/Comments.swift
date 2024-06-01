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
    func getCommentsByProductId(limit: Int, productId: Int, completion: @escaping (_ result: [CommentsStruct]) -> ()) {
            let url = Constants.url + "comments/\(productId)"
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    var arrayComments = [CommentsStruct]()
                    let count = json.count
                    guard count != 0 else {return}
                    
                    for x in 0...count - 1{
                        let comment = json[x]["text"].stringValue
                        let createdAt = json[x]["created_at"].stringValue
                        let phoneNumber = json[x]["user_phone_number"].stringValue
                        let commentsCount = json[x]["comments_count"].intValue
                        let comments = CommentsStruct(comment: comment, createdAt: createdAt, phoneNumber: phoneNumber, commentsCount: commentsCount)
                        arrayComments.append(comments)
                        if x == limit && limit != 0 {
                            print(limit)
                            completion(arrayComments)
                        }
                    }
                    if limit == 0{
                        completion(arrayComments)
                    }
                case .failure(_):
                    print("error")
                }
                
            }
            
        }
    func postComment(productId: Int, phoneNumber: String, text: String) {
        let url = Constants.url + "comments"
        let parameters = [
            "product_id": productId,
            "user_phone_number":phoneNumber,
            "text":text
        ] as [String : Any]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { responseData in
            switch responseData.result {
                
            case .success(let value):
                print(55)
            case .failure(_):
                print("error")
            }
        }
        
        
    }
    }
