//
//  HomeViewController.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var storiesEmpty: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var lentaHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lentaTovarsCollectionView: UICollectionView!
    @IBOutlet weak var multimedia: UIButton!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    var userId: Int?
    var segment: SegmentFilter!
    var products = [Product]()
    var category = [Category]()
    var selectProduct = Product(productID: 0)
    var selectLike = UIButton()
    var stories = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        addObserverInFilter()
        lentaTovarsCollectionView.delegate = self
        lentaTovarsCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        scrollView.delegate = self
        segment = SegmentFilter(firstBtn: instagram, secondBtn: multimedia)
        search.delegate = self
        
        getAllStories()
        getAllCategories()
        getAllTovars()
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
    
    func startLoading() {
        loading.isHidden = false
        lentaTovarsCollectionView.isHidden = true
        loading.startAnimating()
    }
    
    func stopLoading() {
        loading.isHidden = true
        lentaTovarsCollectionView.isHidden = false
        loading.stopAnimating()
    }
    
    func emptyStories() {
        if stories.count != 0{
            storiesCollectionView.isHidden = false
            storiesEmpty.isHidden = true
        }else {
            storiesCollectionView.isHidden = true
            storiesEmpty.isHidden = false
        }
        
    }
    
    func getAllStories() {
        Task {
            let story = try await Stories().getStories()
            print(story)
            self.stories = story
            DispatchQueue.main.async {
                self.storiesCollectionView.reloadData()
                self.emptyStories()
            }
        }
    }
    
    func getAllCategories() {
        Task{
            let categories = try await Categories().getCategories()
            print(categories)
            self.category = categories
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
            }
        }
    }
    
    func getAllTovars() {
        
        startLoading()
        Task{
            let product = try await Tovar().getAllTovars()
            self.products = product
            self.lentaTovarsCollectionView.reloadData()
            self.lentaTovarsCollectionView.reloadSections(IndexSet(integer: 0))
            DispatchQueue.main.async {
                self.stopLoading()
                self.view.layoutSubviews()
            }
        }
    }
    
    func addObserverInFilter() {
        NotificationCenter.default.addObserver(self, selector: #selector(acceptedFilter), name: NSNotification.Name("filterReloadTovars"), object: nil)

    }
    
    @objc func acceptedFilter() {
        
        getAllTovars()
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
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        search.resignFirstResponder()
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == lentaTovarsCollectionView {
            return products.count
        }else if collectionView == categoriesCollectionView {
            return category.count
        }else {
            return stories.count
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
            if stories[indexPath.row].isViwed == false {
                cell.designViews(isViewed: false)
            }else {
                cell.designViews(isViewed: false)
            }
            cell.lbl.text = stories[indexPath.row].content
            cell.image.sd_setImage(with: URL(string: stories[indexPath.row].avatar))
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! CategoriesCollectionViewCell
            cell.im.sd_setImage(with: URL(string: category[indexPath.row].image ?? ""))
            cell.text.text = category[indexPath.row].name
            return cell
        }
    }
    
    func instagramCell(_ indexPath: IndexPath,_ collectionView:UICollectionView) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "instagram", for: indexPath) as! WishlistCollectionViewCell
        cell.image.sd_setImage(with: URL(string: products[indexPath.row].mainImages!))
        cell.itemName.text = products[indexPath.row].title
        Task{
            let likesCount = try await Wishlist().getFavoritesByID(products[indexPath.row].productID)
            DispatchQueue.main.async {
                cell.likes.text = "Лайкнули \(likesCount)"
            }
        }
        cell.nameAuthor.text = products[indexPath.row].author.firstName
        cell.imageAuthor.sd_setImage(with: URL(string: products[indexPath.row].author.avatar))
        //Button
        cell.like.addTarget(self, action: #selector(clickLike), for: .touchUpInside)
        cell.imBtn.addTarget(self, action: #selector(clickProduct), for: .touchUpInside)
        cell.goToAccount.addTarget(self, action: #selector(clickAccount), for: .touchUpInside)
        cell.goToAccount.tag = indexPath.row
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
        cell.reviewsCountLbl.text = "\(products[indexPath.row].rating.totalVotes) reviews"
        cell.ratingLbl.text = "\(products[indexPath.row].rating)"
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == instagram {
            userId = products[indexPath.row].productID
            performSegue(withIdentifier: "goToAccount2", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "product" {
            let vc = segue.destination as! ProductViewController
            vc.product.productID = selectProduct.productID
        }
        if segue.identifier == "goToAccount2" {
            let vc = segue.destination as! AccountViewController
            vc.userId = userId
        }
        
    }
   
        
        
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
//        if bottomEdge >= scrollView.contentSize.height {
//            
//            getAllTovars()
//        }
//    }

    
    // MARK: - UIButton instagram Cell
    
    @objc func clickLike(sender: UIButton){
        if products[sender.tag].meLike == false {
            products[sender.tag].meLike = true
            Task{
                try await Wishlist().addFavorites(products[sender.tag], method: .post)
                self.lentaTovarsCollectionView.reloadData()
            }
        }else {
            products[sender.tag].meLike = false
            Task{
                try await Wishlist().addFavorites(products[sender.tag], method: .delete)
                self.lentaTovarsCollectionView.reloadData()
            }
        }
        
    }
    
    @objc func clickProduct(sender: UIButton) {
        selectProduct = products[sender.tag]
        performSegue(withIdentifier: "product", sender: self)
    }
    @objc func clickAccount(sender: UIButton) {
        userId = products[sender.tag].author.authorId
        performSegue(withIdentifier: "goToAccount2", sender: self)
    }
    
    
}
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Filter.search = textField.text
        getAllTovars()
        textField.resignFirstResponder()
        return true
    }
    
}
