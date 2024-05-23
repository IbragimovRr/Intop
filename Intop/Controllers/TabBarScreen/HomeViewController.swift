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
        self.view.layoutSubviews()
        self.view.setNeedsLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeHeightCollection()
    }
    
    func changeHeightCollection() {
        lentaHeight.constant = lentaTovarsCollectionView.contentSize.height
    }
    
    @IBAction func instagramBtn(_ sender: Any) {
        segment.onFirst()
        lentaTovarsCollectionView.reloadData()
    }
    
    @IBAction func multimedia(_ sender: Any) {
        segment.onSecond()
        lentaTovarsCollectionView.reloadData()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == lentaTovarsCollectionView {
            if segment.select == .instagram {
                return instagramCell(indexPath, collectionView)
            }else {
                return multimediaCell(indexPath, collectionView)
            }
            
        }else if collectionView == storiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "story", for: indexPath) as! StoriesCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategoriesCollectionViewCell
            return cell
        }
    }
    
    func instagramCell(_ indexPath: IndexPath,_ collectionView:UICollectionView) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "instagram", for: indexPath) as! WishlistCollectionViewCell
        
        return cell
    }
    
    func multimediaCell(_ indexPath: IndexPath,_ collectionView:UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "multimedia", for: indexPath) as! WishlistCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == lentaTovarsCollectionView {
            if segment.select == .instagram {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }else {
                return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            }
        }else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lentaTovarsCollectionView {
            if segment.select == .instagram {
                return CGSize(width: UIScreen.main.bounds.width, height: 519)
            }else {
                let widthScreen = UIScreen.main.bounds.width
                let result = (widthScreen / 2) - 40
                return CGSize(width: result, height: 215)
            }
        }else if collectionView == storiesCollectionView {
            return CGSize(width: 63, height: 85)
        }else {
            return CGSize(width: 117, height: 86)
        }
    }
    
}

