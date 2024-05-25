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
    
    private func errorSignUp(_ phoneNumber:String,_ password:String) -> (Bool,String?) {
        guard phoneNumber.count >= 11 else { return (false,"Неверный формат номера телефона") }
        guard  password.isValidPassword() == true else { return (false,"Пароль должен содержать не менее 8 символов и включать как минимум 1 цифру, 1 прописную и 1 строчную ") }
        return (true,nil)
    }
    
    
    func signUpPhone(phoneNumber:String, password: String, shopRole: ShopRole,  completion:@escaping (_ code:Int?, _ error:String?) -> ()) {
        let errorValidate = errorSignUp(phoneNumber, password)
        guard errorValidate.0 else {
            completion(nil, errorValidate.1)
            return }
        
        let url = Constants.url + "users/register"
        
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(Data("\(phoneNumber)".utf8), withName: "user_phone_number")
            multipartFormData.append(Data("\(password)".utf8), withName: "app_password")
        }, to: url,
                  method: .post,
                  headers: headers).response { responseData in
            switch responseData.result {
            case .success(let value):
                let code = responseData.response!.statusCode
                
                if code != 201 {
                    completion(nil, "Номер уже был зарегистрирован")
                    
                }else {
                    UD().savePhone(phoneNumber)
                    UD().saveShopRole(shopRole.rawValue)
                    self.signUpRoleByUser(phoneNumber, shopRole: shopRole)
                    completion(code, nil)
                }
            case .failure(_):
                completion(nil, "Ошибка повторите попытку позже")
            }
        
        }
        
    }
    
    private func signUpRoleByUser(_ phoneNumber:String,shopRole:ShopRole) {
        //Регистрация под покупателя
        User().getInfoUser(phoneNumber) { info in
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

    
    func signInPhone(phoneNumber:String,password:String, isSeller:Bool ,completion:@escaping (_ resultCode:Int?,_ error:String?) -> ()) {
        let url = Constants.url + "users/login"
        
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
                        completion(nil,"Неправильный логин или пароль")
                    }else if code == 201 {
                        //Успешный логин пароль
                        UD().savePhone(phoneNumber)
                        UD().saveRemember(true)
                        User().getInfoUser(phoneNumber) { info in
                            if info.is_seller == isSeller {
                                completion(code,nil)
                            }else if info.is_seller == true && isSeller == false {
                                completion(code,nil)
                            }else {
                                completion(nil,"Ошибка данных")
                            }
                        }
                        
                    }
                    case .failure(_):
            completion(nil,"Ошибка повторите попытку позже")
            }
        }
    }

    // MARK: - Code
    
    func sendCode(_ phoneNumber:String, completion: @escaping (_ code:String) -> ()) {
        let url = Constants.url + "get_code_send_sms/\(phoneNumber)"
        AF.request(url,method: .get).responseData { responseData in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["code_will_be_REMOVED"].stringValue
                    print(result)
                    completion(result)
                
            case .failure(let error):
                print(error)
            }
        }
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


