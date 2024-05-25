//
//  Stories.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 16.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class Stories {
    
    func getStories(completion:@escaping () -> ()) {
        let url = Constants.url + "stories"
        AF.request(url, method: .get).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                guard json.count != 0 else { return }
                for x in 0...json.count - 1 {
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
