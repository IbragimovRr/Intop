//
//  Rating.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 28.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Rating {
    
    func getRatingByProductId(productId: Int) async throws -> RatingStruct {
        let url = Constants.url + "products/rating?product_id=\(productId)"
        let value = try await AF.request(url, method: .get).serializingData().value
        let json = JSON(value)
        let averageRating = json["rating_stats"]["rating_stats"]["average_rating"].floatValue
        let totalVotes = json["rating_stats"]["rating_stats"]["total_votes"].intValue
        let rating = RatingStruct(rating: averageRating, totalVotes: totalVotes)
        return rating
    }
    
    func getRatingByUserId(productId: Int, completion: @escaping (_ result:RatingStruct) ->()) {
        let url = Constants.url + "products/rating?product_id=\(productId)"
    }
    
}
