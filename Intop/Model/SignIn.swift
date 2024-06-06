//
//  SignIn.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class Sign {
    
    private let headers:HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    // MARK: - Sign Up
    
    private func errorSignUp(_ phoneNumber:String,_ password:String) async throws -> Bool {
        guard phoneNumber.count >= 11 else { throw ErrorSignUp.invalidPhoneNumber }
        guard  password.isValidPassword() == true else { throw ErrorSignUp.invalidPassword }
        return true
    }
    
    
    func signUpPhone(phoneNumber:String, password: String, shopRole: ShopRole) async throws -> Int {
        _ = try await errorSignUp(phoneNumber, password)
        
        let url = Constants.url + "users/register"
        
        let responseData = AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(Data("\(phoneNumber)".utf8), withName: "user_phone_number")
            multipartFormData.append(Data("\(password)".utf8), withName: "app_password")
        }, to: url,
        method: .post,
        headers: headers).serializingData()
        let value = try await responseData.value

        let code = await responseData.response.response!.statusCode
        
        if code != 201 {
            throw ErrorSignUp.namberRegister
            
        }else {
            UD().savePhone(phoneNumber)
            UD().saveShopRole(shopRole.rawValue)
            self.signUpRoleByUser(phoneNumber, shopRole: shopRole)
            return code
        }
    }
    
    private func signUpRoleByUser(_ phoneNumber:String,shopRole:ShopRole) {
        //Регистрация под покупателя
        Task{
            let info = try await User().getInfoUser(phoneNumber)
            let url = Constants.url + "update_user_phone_number"
            let parametrs = [
                "user_id":info.id,
                "user_phone_number":phoneNumber,
                "shop_role":shopRole.rawValue
            ]
            AF.request(url, method: .put, parameters: parametrs).responseString { response in }
            // Регистраиця под продавца
            if shopRole == .sellerIndividual || shopRole == .sellerLegal {
                self.signUpSeller(phoneNumber, shopRole: shopRole)
            }
        }
    }
    
    private func signUpSeller(_ phoneNumber:String,shopRole:ShopRole) {
        let url = Constants.url + "become_seller/\(phoneNumber)?shop_role=\(shopRole.rawValue)"
        AF.request(url, method: .get).responseString { response in }
    }

    // MARK: - Sign In

    
    func signInPhone(phoneNumber:String,password:String, isSeller:Bool) async throws -> Int {
        let url = Constants.url + "users/login"
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(Data("\(phoneNumber)".utf8), withName: "user_phone_number")
                multipartFormData.append(Data("\(password)".utf8), withName: "app_password")
                
            }, to: url,
                      method: .post,
                      headers: headers).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    
                    let code = responseData.response!.statusCode
                    if code == 403{
                        continuation.resume(throwing: ErrorSignIn.invalidLoginOrPassword)
                    }else if code == 201 {
                        //Успешный логин пароль
                        UD().savePhone(phoneNumber)
                        UD().saveRemember(true)
                        Task{
                            let info = try await User().getInfoUser(phoneNumber)
                            if info.is_seller == isSeller {
                                continuation.resume(returning:code)
                            }else if info.is_seller == true && isSeller == false {
                                continuation.resume(returning:code)
                            }else {
                                continuation.resume(throwing: ErrorSignIn.notFound)
                            }
                            
                            
                        }
                    }
                case .failure(_):
                    continuation.resume(throwing: ErrorSignIn.tryAgainLater)
                }
            }
        }
    }

    // MARK: - Code
    
    func sendCode(_ phoneNumber:String) async throws -> String{
        let url = Constants.url + "get_code_send_sms/\(phoneNumber)"
        let value = try await AF.request(url,method: .get).serializingData().value
        let json = JSON(value)
        let result = json["code_will_be_REMOVED"].stringValue
        print(result)
        return result
    }
    

    // MARK: - Other
    
    func goToSign(_ viewController:UIViewController,completion: (() -> ())?) {
        if UD().getSignUser() == false {
            viewController.performSegue(withIdentifier: "vhod", sender: self)
        }else {
            completion?()
        }
    }
    
}


