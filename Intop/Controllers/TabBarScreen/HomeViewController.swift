//
//  HomeViewController.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var multimedia: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    var segment: SegmentFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        segment = SegmentFilter(firstBtn: instagram, secondBtn: multimedia)
    }
    
    @IBAction func seeAllCategoriesBtn(_ sender: UIButton) {
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
    }
    
    @IBAction func multimediaBtn(_ sender: UIButton) {
        segment?.onSecond()
    }
    
    @IBAction func instagramBtn(_ sender: UIButton) {
        segment?.onFirst()
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
    }
    
    @IBAction func favoritesBtn(_ sender: UIButton) {
    }
    

}
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "story", for: indexPath) as! StoriesCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategoriesCollectionViewCell
            return cell
        }
    }
    
    
}
