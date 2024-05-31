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
    
    
    func getCategories(completion: @escaping (_ result:[Category]) -> ()) {
        
        let url = Constants.url + "categories/nested"
        
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                let categoriesArray = self.parseCategories(json: json)
                completion(categoriesArray)
                
            case .failure(_):
                print("error")
            }
        }
    }
    
    func parseCategories(json: JSON) -> [Category] {
        var categories = [Category]()
        
        for (_, categoryJSON) in json {
            let category = Category(json: categoryJSON)
            categories.append(category)
        }
        
        return categories
    }



    
    
    
}
