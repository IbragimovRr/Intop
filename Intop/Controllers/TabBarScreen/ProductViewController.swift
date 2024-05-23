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
    

    var idProduct:Int?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
                
    }
//    func addInfo() {
//        guard let user = user else {return}
//        firstName.text = user.name
//        avatar.sd_setImage(with: URL(string: user.avatar))
//
//    }
    
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
