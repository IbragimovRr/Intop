//
//  UD.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation

class UD {
    
    func savePhone(_ phoneNumber:String) {
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
    }
    
    func getPhone() -> String? {
        guard let phone = UserDefaults.standard.string(forKey: "phoneNumber") else { return nil }
        return phone
    }
    
    func saveRemember(_ remember:Bool) {
        UserDefaults.standard.set(remember, forKey: "remember")
    }
    
    func getRemember() -> Bool? {
        let remember = UserDefaults.standard.bool(forKey: "remember") 
        return remember
    }
}
