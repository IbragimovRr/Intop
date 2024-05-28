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
    var products = [Product]()
    var selectProduct = Product(productID: 0)
    var selectLike = UIButton()
    
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
        Tovar().getAllTovars { product in
            self.products = product
            self.lentaTovarsCollectionView.reloadData()
            self.lentaTovarsCollectionView.reloadSections(IndexSet(integer: 0))
        }
        
        self.view.layoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lentaTovarsCollectionView.reloadData()
        lentaTovarsCollectionView.reloadSections(IndexSet(integer: 0))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeHeightCollection()
    }
    
    func changeHeightCollection() {
        lentaHeight.constant = lentaTovarsCollectionView.contentSize.height
    }
    
    @IBAction func instagramBtn(_ sender: Any) {
        DispatchQueue.main.async {
            self.segment.onFirst()
            self.lentaTovarsCollectionView.reloadData()
        }
    }
    
    @IBAction func multimedia(_ sender: Any) {
        DispatchQueue.main.async {
            self.segment.onSecond()
            self.lentaTovarsCollectionView.reloadData()
        }
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
        if collectionView == lentaTovarsCollectionView {
            return products.count
        }else {
            return 10
        }
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
        cell.image.sd_setImage(with: URL(string: products[indexPath.row].mainImages!))
        cell.itemName.text = products[indexPath.row].title
        Wishlist().getFavoritesByID(products[indexPath.row].productID) { likesCount in
            DispatchQueue.main.async {
                cell.likes.text = "Лайкнули \(likesCount)"
            }
        }
        cell.nameAuthor.text = products[indexPath.row].author.firstName
        cell.imageAuthor.sd_setImage(with: URL(string: products[indexPath.row].author.avatar))
        //Button
        cell.like.addTarget(self, action: #selector(clickLike), for: .touchUpInside)
        cell.imBtn.addTarget(self, action: #selector(clickProduct), for: .touchUpInside)
        
        cell.imBtn.tag = indexPath.row
        cell.like.tag = indexPath.row
        if products[indexPath.row].meLike == true {
            cell.like.setImage(UIImage(named: "likeFull2"), for: .normal)
        }else {
            cell.like.setImage(UIImage(named: "like2"), for: .normal)
        }
        return cell
    }
    
    
    
    func multimediaCell(_ indexPath: IndexPath,_ collectionView:UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "multimedia", for: indexPath) as! WishlistCollectionViewCell
        cell.image.sd_setImage(with: URL(string: products[indexPath.row].mainImages!))
        cell.itemName.text = products[indexPath.row].title
        cell.priceLbl.text = "$\(products[indexPath.row].priceUSD!)"
        cell.reviewsCountLbl.text = "\(products[indexPath.row].reviews!) reviews"
        //Button
        cell.imBtn.addTarget(self, action: #selector(clickProduct), for: .touchUpInside)
        cell.imBtn.tag = indexPath.row
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lentaTovarsCollectionView {
            if segment.select == .instagram {
                return CGSize(width: UIScreen.main.bounds.width, height: 550)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "product" {
            let vc = segue.destination as! ProductViewController
            vc.idProduct = selectProduct.productID
        }
        
    }
    
    // MARK: - UIButton instagram Cell
    
    @objc func clickLike(sender: UIButton){
        if products[sender.tag].meLike == false {
            products[sender.tag].meLike = true
            Wishlist().addFavorites(products[sender.tag], method: .post) {
                self.lentaTovarsCollectionView.reloadData()
            }
        }else {
            products[sender.tag].meLike = false
            Wishlist().addFavorites(products[sender.tag], method: .delete) {
                self.lentaTovarsCollectionView.reloadData()
            }
        }
        
    }
    
    @objc func clickProduct(sender: UIButton) {
        selectProduct = products[sender.tag]
        performSegue(withIdentifier: "product", sender: self)
    }
    
    
}

