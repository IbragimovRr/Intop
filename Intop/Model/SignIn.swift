//
//  SignIn.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import Alamofire

class SignIn {
    
    private var url = "https://api.intop.uz/monolith/"
    private let headers:HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func signInPhone(phoneNumber:String,password:String) {
        url += "users/login"
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(Data("\(phoneNumber)".utf8), withName: "user_phone_number")
            multipartFormData.append(Data("RU".utf8), withName: "lang_code")
            multipartFormData.append(Data("\(password)".utf8), withName: "app_password")
            
        }, to: "https://api.intop.uz/monolith/users/register",
                  method: .post,
                  headers: headers).responseData { responseData in
            
        }
    }
    
    private func jsonInData(_ responseData: Data) {
        //Commit
    }
    
    
}
