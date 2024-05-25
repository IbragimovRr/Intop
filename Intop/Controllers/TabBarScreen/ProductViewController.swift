//
//  ProductViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 22.05.2024.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var commentHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var likesCountLbl: UILabel!
    @IBOutlet weak var priceUSDLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var reviewsLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    
    var idProduct: Int?
    var product: Product?
    var comments = [CommentsStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        sizeCollectionView.delegate = self
        commentCollectionView.dataSource = self
        commentCollectionView.delegate = self
        scrollView.delegate = self
        Tovar().getTovarById(productId: idProduct!) { result in
            self.product = result
            self.addAuthorInfo()
            self.addTovarInfo()
        }
        Comments().getCommentsByProductId(productId: idProduct!) { result in
            self.comments = result
            self.commentCollectionView.reloadData()
        }
        
        self.view.layoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeCollectionViewHeight()
    }
    func addAuthorInfo() {
        guard let product = product else {return}
        firstName.text = product.author.firstName
        avatar.sd_setImage(with: URL(string: product.author.avatar))

    }
    func addTovarInfo() {
        guard let product = product else {return}
        priceUSDLbl.text = "$\(product.priceUSD!)"
        titleLbl.text = product.title
        reviewsLbl.text = "\(product.reviews!) reviews"
        descriptionLbl.text = product.description
        if product.likes! > 0 {
            likesCountLbl.text = "Лайкнул кто-то и \(product.likes!) других"
        }else {
            likesCountLbl.text = "Никто не лайкнул"
        }
        imageCollectionView.reloadData()
    }
    func changeCollectionViewHeight() {
        commentHeight.constant = commentCollectionView.contentSize.height
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            guard product?.image != nil else {return 0}
            return product!.image!.count
        }else if collectionView == sizeCollectionView {
            return 10
        }else {
            return comments.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            cell.image.sd_setImage(with: URL(string: (product!.image![indexPath.row])))
            return cell
        }else if collectionView == sizeCollectionView {
            let cell = sizeCollectionView.dequeueReusableCell(withReuseIdentifier: "sizeCell", for: indexPath) as! SizeCollectionViewCell
            return cell
        }else {
            let cell = commentCollectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as! CommentCollectionViewCell
            
            cell.comment.text = comments[indexPath.row].comment
            User().getInfoUser(comments[indexPath.row].phoneNumber, completion: { info in
                cell.author.text = info.name
                cell.avatar.sd_setImage(with: URL(string: info.avatar))
            })
            cell.createdAt.text = comments[indexPath.row].createdAt
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 375)
        }else if collectionView == sizeCollectionView {
            return CGSize(width: 40, height: 40)
        }else {
            return CGSize(width: UIScreen.main.bounds.width - 52, height: 128)
        }
    }
    
    
}

