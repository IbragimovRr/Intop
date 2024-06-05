//
//  CategoriesViewController.swift
//  Intop
//
//  Created by Руслан on 22.05.2024.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoriesViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getFavorites() async throws -> [Product] {
        let id = 8096
        let url = Constants.url + "likes/products/\(id)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).responseData { responseData in
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let count = json.count
                    guard count != 0 else { return continuation.resume(returning: [Product]()) }
                    var arrayFavorites = [Product]()
                    for x in 0...count - 1 {
                        let title = json[x]["title"].stringValue
                        let mainImage = json[x]["main_image_url"].stringValue
                        let price = json[x]["price"].intValue
                        let productID = json[x]["id"].intValue
                        let favorites = Product(title: title,priceUSD: price, productID: productID, mainImages: mainImage)
                        arrayFavorites.append(favorites)
                    }
                    continuation.resume(returning: arrayFavorites)
                case .failure(_):
                    print("error")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Sign().goToSign(self, completion: nil)
    }


}
