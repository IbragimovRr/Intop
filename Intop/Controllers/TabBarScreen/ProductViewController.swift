//
//  ProductViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 22.05.2024.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var likesCountLbl: UILabel!
    @IBOutlet weak var priceUSDLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var reviewsLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    
    var idProduct:Int?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        Tovar().getTovarById(productId: idProduct!) { result in
            self.product = result
            self.addAuthorInfo()
        }
        
                
    }
    func addAuthorInfo() {
        guard let product = product else {return}
        firstName.text = product.author?.firstName
        avatar.sd_setImage(with: URL(string: product.author!.avatar))

    }
    func addTovarInfo() {
        guard let product = product else {return}
        
    }
    
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
        return cell
    }
    
    
}
