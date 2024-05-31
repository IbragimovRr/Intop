//
//  ProductViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 22.05.2024.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var ConditionIfNil: UILabel!
    @IBOutlet weak var descriptionIfNil: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var likesCountLbl: UILabel!
    @IBOutlet weak var priceUSDLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var reviewsLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    
    var userId = 0
    var idProduct: Int?
    var product: Product?
    var comments = [CommentsStruct]()
    var sizes = [String]()
    var rating: RatingStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(idProduct, 232)
        performSegue(withIdentifier: "loading", sender: self)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        commentCollectionView.dataSource = self
        commentCollectionView.delegate = self
        scrollView.delegate = self
        getComments(limit: 1)
        getTovar()
        getRating()
        
        self.view.layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeCollectionViewHeight()
    }
    
    func getRating() {
        Rating().getRatingByProductId(productId: idProduct!) { result in
            print(result)
            self.rating = result
        }
    }
    
    func getTovar() {
        Tovar().getTovarById(productId: idProduct!) { result in
            self.product = result
            self.addAuthorInfo()
            self.addTovarInfo()
            self.dismiss(animated: false)
        }
    }
    func getComments(limit: Int) {
        Comments().getCommentsByProductId(limit: limit, productId: idProduct!) { result in
            self.comments = result
            self.commentCollectionView.reloadData()
        }
    }
    
    func addAuthorInfo() {
        guard let product = product else {return}
        firstName.text = product.author.firstName
        avatar.sd_setImage(with: URL(string: product.author.avatar))

    }
    
    func addTovarInfo() {
        guard let product = product else {return}
        guard let rating = rating else {return}
        priceUSDLbl.text = "$\(product.priceUSD!)"
        titleLbl.text = product.title
        reviewsLbl.text = "\(rating.totalVotes) reviews"
        ratingLbl.text = "\(rating.rating)"
        
        design()
        imageCollectionView.reloadData()
    }
    
    func design() {
        guard let product = product else {return}
    
        if product.meLike == true {
            likeBtn.setImage(UIImage(named: "likeFull2"), for: .normal)
        }else {
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
        }
        
        ConditionIfNil.isHidden = true
        
        if product.description != "" || product.description != nil {
            descriptionLbl.text = product.description
        }else {
            descriptionIfNil.isHidden = true
        }
        
        if product.likes! > 0 {
            likesCountLbl.text = "Лайкнул кто-то и \(product.likes!) других"
        }else {
            likesCountLbl.text = "Никто не лайкнул"
        }
        self.view.layoutSubviews()
    }
    
    func changeCollectionViewHeight() {
        commentHeight.constant = commentCollectionView.contentSize.height
    }
    
    @IBAction func goToAccount(_ sender: UIButton) {
        userId = (product?.author.authorId)!
    }
    
    @IBAction func addLike(_ sender: UIButton) {
        guard let product = product else {return}
        if product.meLike == false {
            self.product!.meLike = true
            Wishlist().addFavorites(product, method: .post, completion: nil)
            likeBtn.setImage(UIImage(named: "likeFull2"), for: .normal)
        }else {
            self.product!.meLike = false
            Wishlist().addFavorites(product, method: .delete, completion: nil)
            likeBtn.setImage(UIImage(named: "like2"), for: .normal)
        }

    }
    
    @IBAction func allCommentsBtn(_ sender: UIButton) {
        getComments(limit: 0)
        stackView.isHidden = true
            
    }
    
    @IBAction func allCommentsBtn2(_ sender: UIButton) {
        getComments(limit: 0)
        stackView.isHidden = true
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            guard product?.image != nil else {return 0}
            return product!.image!.count
        }else {
            return comments.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            cell.image.sd_setImage(with: URL(string: (product!.image![indexPath.row])))
            return cell
        }else {
            let cell = commentCollectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as! CommentCollectionViewCell
            
            cell.comment.text = comments[indexPath.row].comment
            User().getInfoUser(comments[indexPath.row].phoneNumber, completion: { info in
                cell.author.text = info.name
                cell.avatar.sd_setImage(with: URL(string: info.avatar))
            })
            let dateStr = comments[indexPath.row].createdAt
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "DDD, dd MMM yyyy HH:mm:ss GMT"
            let date = dateFormatter.date(from: dateStr)
            dateFormatter.dateFormat = "h:mm a"
            //            print(dateFormatter.string(from:date!))
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 375)
        }else {
            return CGSize(width: UIScreen.main.bounds.width - 52, height: 128)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToAccount" {
            let vc = segue.destination as! AccountViewController
            vc.userId = userId
        }
        
    }
}
