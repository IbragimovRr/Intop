//
//  WishlistViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 18.05.2024.
//

import UIKit
import SDWebImage

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    
    var wishlists = [Favorites]()
    var selectId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        Wishlist().getFavorites { result in
            self.wishlists = result
            self.wishlistCollectionView.reloadData()
            
        }
    }
        //    override func viewDidAppear(_ animated: Bool) {
        //        super.viewDidAppear(animated)
        //        Wishlist().getFavorites { result in
        //            self.wishlists = result
        //            self.wishlistCollectionView.reloadData()
        //        }
        //    }
        //
        @IBAction func likeBtn(_ sender: UIButton) {
            
        }
        
        
        
    }
    extension WishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return wishlists.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = wishlistCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WishlistCollectionViewCell
            cell.priceLbl.text = "$\(wishlists[indexPath.row].price)"
            cell.itemName.text = wishlists[indexPath.row].title
            cell.reviewsCountLbl.text = "\(wishlists[indexPath.row].reviews) reviews"
            cell.image.sd_setImage(with: URL(string: wishlists[indexPath.row].mainImage) )
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectId = wishlists[indexPath.row].tovarId
            performSegue(withIdentifier: "goToProduct", sender: self)
            
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToProduct" {
                let vc = segue.destination as! ProductViewController
                vc.idProduct = selectId
            }
        }
    }

