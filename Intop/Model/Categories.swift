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
                print(json["1"]["subcategories"])
                let categoriesName = json["1"]["name"].stringValue
                
            case .failure(_):
                print("error")
            }
        }
    }
    
}
