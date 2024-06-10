//
//  ChatCollectionViewCell.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 16.05.2024.
//

import UIKit

class StoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    func designViews(isViewed:Bool) {
        if isViewed == false {
            let gradient = UIImage.gradientImage(bounds: viewBack.bounds, colors: [UIColor(named: "GradienStories")!, UIColor(named: "GradienStories2")!])
            let gradientColor = UIColor(patternImage: gradient)
            viewBack.layer.borderColor = gradientColor.cgColor
            viewBack.layer.borderWidth = 1.5
        }else {
            let gradient = UIImage.gradientImage(bounds: viewBack.bounds, colors: [UIColor.gray, UIColor.gray])
            let gradientColor = UIColor(patternImage: gradient)
            viewBack.layer.borderColor = gradientColor.cgColor
            viewBack.layer.borderWidth = 1.5
        }
    }
}
