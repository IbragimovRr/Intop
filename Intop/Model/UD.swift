//
//  UD.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation

class UD {
    
//    func saveFilter() {
//        UserDefaults.standard.set(Filter.isAscending, forKey: "isAscending")
//        UserDefaults.standard.set(Filter.isNearby, forKey: "isNearby")
//        UserDefaults.standard.set(Filter.isNegotiable, forKey: "isNegotiable")
//        UserDefaults.standard.set(Filter.isNew, forKey: "isNew")
//        UserDefaults.standard.set(Filter.isSellerVerified, forKey: "isSellerVerified")
//        UserDefaults.standard.set(Filter.priceDo, forKey: "priceDo")
//        UserDefaults.standard.set(Filter.priceOt, forKey: "priceOt")
//        UserDefaults.standard.set(Filter.valuta, forKey: "valuta")
//    }
//    
//    func getFilter() -> Filter.Type {
//        var filter = Filter.self
//        filter.isAscending = UserDefaults.standard.bool(forKey: "isAscending")
//        filter.isNearby = UserDefaults.standard.bool(forKey: "isNearby")
//        filter.isNegotiable = UserDefaults.standard.bool(forKey: "isNegotiable")
//        filter.isNew = UserDefaults.standard.bool(forKey: "isNew")
//        filter.isSellerVerified = UserDefaults.standard.bool(forKey: "isSellerVerified")
//        filter.priceDo = UserDefaults.standard.integer(forKey: "priceDo")
//        filter.priceOt = UserDefaults.standard.integer(forKey: "priceOt")
//        filter.valuta = UserDefaults.standard.string(forKey: "valuta")
//        print(filter.priceDo)
//        return filter
//    }
    
    func saveSignUser(_ current: Bool) {
        UserDefaults.standard.set(current, forKey: "sign")
    }
    
    func getSignUser() -> Bool? {
        let current = UserDefaults.standard.bool(forKey: "sign")
        return current
    }
    
    func saveCurrentUser(_ current: Bool) {
        UserDefaults.standard.set(current, forKey: "current")
    }
    
    func getCurrentUser() -> Bool? {
        let current = UserDefaults.standard.bool(forKey: "current")
        return current
    }
    
    func saveShopRole(_ shopRole: String) {
        UserDefaults.standard.set(shopRole, forKey: "shopRole")
    }
    
    func getShopRole() -> String? {
        guard let shopRole = UserDefaults.standard.string(forKey: "shopRole") else {
            return nil }
        return shopRole
    }
    
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
