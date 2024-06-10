//
//  Categories.swift
//  Intop
//
//  Created by Руслан on 22.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Categories {
    
    
    func getCategories() async throws -> [Category] {
        
        let url = Constants.url + "categories/nested"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let categoriesArray = self.parseCategories(json: json)
                    continuation.resume(returning: categoriesArray)
                    
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    
    func parseCategories(json: JSON) -> [Category] {
        var categories = [Category]()
        
        for (_, categoryJSON) in json {
            guard categoryJSON["name"].stringValue != "No category" else { continue }
            let category = Category(json: categoryJSON)
            categories.append(category)
        }
        
        return categories
    }



    
    
    
}
