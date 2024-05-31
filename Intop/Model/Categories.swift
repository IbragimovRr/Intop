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
        
        let url = Constants.url + "categories/all"
        
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                var category = Category(name: "")
                for x in 0...json.count - 1 {
                    let image = json[x]["image_url"].stringValue
                    let name =  json[x]["name"].stringValue
                    let parentID = json[x]["parent_category_id"].stringValue
                    if parentID == "" {
                        
                    }
                }
                
            case .failure(_):
                print("error")
            }
        }
    }
    
}
