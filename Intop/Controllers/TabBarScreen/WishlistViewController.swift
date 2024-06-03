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
    var products = [Product]()
    var selectId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        
        Tovar().getAllTovars { product in
            self.products = product
            self.wishlistCollectionView.reloadData()
        }
        
        Wishlist().getFavorites { result in
            self.wishlists = result
            self.wishlistCollectionView.reloadData()
            
        }
    }
    @IBAction func likeBtn(_ sender: UIButton) {
        
    }
        
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
            Rating().getRatingByProductId(productId: wishlists[indexPath.row].tovarId) { result in
                cell.reviewsCountLbl.text = "\(result.totalVotes) reviews"
                cell.ratingLbl.text = "\(result.rating)"
            }
            
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

