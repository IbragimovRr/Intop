//
//  User.swift
//  Intop
//
//  Created by Руслан on 16.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    static var phoneNumber:String {
        get {
            return UD().getPhone() ?? ""
        }
    }
    
    func getInfoUser(_ phoneNumber:String, completion:@escaping (_ info:JSONUser) -> ()) {
        let url = Constants.url + "users/\(phoneNumber)"
        
        AF.request(url).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                
                let result = json
            
            case .failure(_):
                print("Error")
            }
        }
    }
    
    
    
}
