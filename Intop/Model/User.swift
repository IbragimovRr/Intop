//
//  User.swift
//  Intop
//
//  Created by Руслан on 16.05.2024.
//

import Foundation
import Alamofire

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
                self.jsonInData(value) { result in
                    completion(result)
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    private func jsonInData(_ responseData:Data, completion:@escaping (_ result: JSONUser) -> ()) {
        do {
            var json = try JSONDecoder().decode(JSONUser.self, from: responseData)
            if json.is_seller == nil {
                json.is_seller = false
            }
            completion(json)
        }catch let error {
            print("error \(error)")
        }
    }
    
    
}
