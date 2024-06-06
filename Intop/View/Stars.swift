//
//  Stars.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 06.06.2024.
//

import Foundation
import UIKit
import SDWebImage

class Stars {
    func productRating(firstStar: UIImageView, secondStar: UIImageView, thirdStar: UIImageView, fourthStar: UIImageView, fifthStar: UIImageView, product: RatingStruct) {
        firstStar.image = UIImage(named: "emptyStar")!
        secondStar.image = UIImage(named: "emptyStar")!
        thirdStar.image = UIImage(named: "emptyStar")!
        fourthStar.image = UIImage(named: "emptyStar")!
        fifthStar.image = UIImage(named: "emptyStar")!
        switch Int(product.rating) {
            case 1:
                firstStar.image = UIImage(named: "star")
            case 2:
                firstStar.image = UIImage(named: "star")
                secondStar.image = UIImage(named: "star")
            case 3:
                firstStar.image = UIImage(named: "star")
                secondStar.image = UIImage(named: "star")
                thirdStar.image = UIImage(named: "star")
            case 4:
                firstStar.image = UIImage(named: "star")
                secondStar.image = UIImage(named: "star")
                thirdStar.image = UIImage(named: "star")
                fourthStar.image = UIImage(named: "star")
            case 5:
                firstStar.image = UIImage(named: "star")
                secondStar.image = UIImage(named: "star")
                thirdStar.image = UIImage(named: "star")
                fourthStar.image = UIImage(named: "star")
                fifthStar.image = UIImage(named: "star")
        default:
            break
        }
    }
}
