//
//  WishlistViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 18.05.2024.
//

import UIKit

class WishlistViewController: UIViewController {

    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
       
    }
    
    @IBAction func likeBtn(_ sender: UIButton) {
        
    }
    


}
extension WishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishlistCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WishlistCollectionViewCell
        return cell
    }
    
    
}
