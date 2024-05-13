//
//  SignIn.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import Alamofire

class Sign {
    
    private var url = "https://api.intop.uz/monolith/"
    private let headers:HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    // MARK: - Sign In
    
    func signInPhone(phoneNumber:String,password:String,completion:@escaping (_ result:String?,_ error:String?) -> ()) {
        url += "users/login"
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(Data("\(phoneNumber)".utf8), withName: "user_phone_number")
            multipartFormData.append(Data("\(password)".utf8), withName: "app_password")
            
        }, to: url,
                  method: .post,
                  headers: headers).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                self.jsonInData(value) { result in
                    if result == "No user with this user_phone_number in database or you entered a wrong password"{
                        completion(nil,"Неправильный логин или пароль")
                    }else {
                        UD().savePhone(phoneNumber)
                        completion(result,nil)
                    }
                }
            case .failure(_):
                completion(nil,"Ошибка повторите попытку позже")
            }
        }
    }
    
    private func jsonInData(_ responseData: Data,completion:@escaping (String) -> ()) {
        do {
            let json = try JSONDecoder().decode(JSONSign.self, from: responseData)
            completion(json.details)
        }catch let error {
            print(error)
        }
    }
    
    private func errorSignUp(_ phoneNumber:String,_ password:String) -> Bool {
        guard phoneNumber.count == 13 else { return false }
        guard password.count >= 8 else { return false }
        return true
    }
    
    // MARK: - Code
    
    func sendCode(_ phoneNumber:String, completion: @escaping (_ code:String) -> ()) {
        url += "get_code_send_sms/\(phoneNumber)"
        AF.request(url).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                self.jsonInDataCode(value) { code in
                    print(code)
                    completion(code)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func jsonInDataCode(_ responseData: Data,completion:@escaping (String) -> ()) {
        do {
            let json = try JSONDecoder().decode(JSONCode.self, from: responseData)
            completion(json.code)
        }catch let error {
            print(error)
        }
    }
    
}


