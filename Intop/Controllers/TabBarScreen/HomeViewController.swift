//
//  HomeViewController.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lentaHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lentaTovarsCollectionView: UICollectionView!
    @IBOutlet weak var multimedia: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    var segment: SegmentFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        lentaTovarsCollectionView.delegate = self
        lentaTovarsCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        scrollView.delegate = self
        segment = SegmentFilter(firstBtn: instagram, secondBtn: multimedia)
        Categories().getCategories { result in
            
        }
        
    }
    
    @IBAction func instagramBtn(_ sender: Any) {
        segment.onFirst()
    }
    
    @IBAction func multimedia(_ sender: Any) {
        segment.onSecond()
    }
    
    
    @IBAction func wishlist(_ sender: UIButton) {
        Sign().goToSign(self, completion: {
            self.performSegue(withIdentifier: "wishlist", sender: self)
        })
    }
    
    @IBAction func cart(_ sender: Any) {
        Sign().goToSign(self, completion: nil)
    }
    
    @IBAction func checkCategories(_ sender: Any) {
        Sign().goToSign(self, completion: nil)
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == lentaTovarsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "multimedia", for: indexPath) as! WishlistCollectionViewCell
            return cell
        }else if collectionView == storiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "story", for: indexPath) as! StoriesCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategoriesCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lentaTovarsCollectionView {
            let widthScreen = UIScreen.main.bounds.width
            let result = (widthScreen / 2) - 40
            return CGSize(width: result, height: 215)
        }else if collectionView == storiesCollectionView {
            return CGSize(width: 63, height: 85)
        }else {
            return CGSize(width: 117, height: 86)
        }
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.scrollView.contentSize.height = lentaTovarsCollectionView.contentSize.height + 20
//        lentaHeight.constant = lentaTovarsCollectionView.contentSize.height + 20
//        lentaTovarsCollectionView.layoutIfNeeded()
//    }
}
