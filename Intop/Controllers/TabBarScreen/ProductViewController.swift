//
//  ProductViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 22.05.2024.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var viewComment: Border!
    @IBOutlet weak var emptyComment: UILabel!
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
    
    var userPhoneNumber: String?
    var userId = 0
    var idProduct: Int?
    var product: Product?
    var sizes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        performSegue(withIdentifier: "loading", sender: self)
        viewComment.layer.borderColor = UIColor(named: "GrayMain")?.cgColor
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        commentCollectionView.dataSource = self
        commentCollectionView.delegate = self
        scrollView.delegate = self
        getComments(limit: 0)
        getTovar()
        getRating()
        
        
        
        
        self.view.layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeCollectionViewHeight()
    }
    
    func isEmptyComments(comments: [CommentsStruct]) {
        if comments.isEmpty {
            emptyComment.isHidden = false
            commentCollectionView.isHidden = true
            stackView.isHidden = true
        }else{
            emptyComment.isHidden = true
            commentCollectionView.isHidden = false
            if comments.count <= 2 {
                stackView.isHidden = true
            }else {
                stackView.isHidden = false
            }
        }
    }
    
    func getRating() {
        Rating().getRatingByProductId(productId: idProduct!) { result in
            self.product!.rating = result
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
            self.isEmptyComments(comments: result)
            self.product!.comments = result
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
        priceUSDLbl.text = "$\(product.priceUSD!)"
        titleLbl.text = product.title
        reviewsLbl.text = "\(product.rating.totalVotes) reviews"
        ratingLbl.text = "\(product.rating.rating)"
        
        design()
        imageCollectionView.reloadData()
    }
    
    func design() {
        guard let product = product else {return}
        
        pageControl.numberOfPages = product.image!.count
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
        userPhoneNumber = product?.author.firstName
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
    
    @IBAction func postComment(_ sender: UIButton) {
        if UD().getCurrentUser() == true {
            if commentTextField.text != "" {
                Comments().postComment(productId: idProduct!, phoneNumber: User.phoneNumber, text: commentTextField.text!)
                product!.comments.insert((CommentsStruct(comment: commentTextField.text!, createdAt: "", phoneNumber: User.phoneNumber)), at: 0)
                commentTextField.text = ""
                commentCollectionView.reloadData()
                
            }
        }else{
            let alert = UIAlertController(title: "Требуется регистрация", message: "Зарегистрируйтесь, чтобы оставить отзыв", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "регистрация", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "goToRegister", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
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
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentBtn(_ sender: Any) {
        let result =  commentLbl.frame.origin.y - (UIScreen.main.bounds.height / 1.515)
        scrollView.setContentOffset(CGPoint(x: 0, y: result), animated: true)
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            guard product?.image != nil else {return 0}
            return product!.image!.count
        }else {
            return product!.comments.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            cell.image.sd_setImage(with: URL(string: (product!.image![indexPath.row])))
            
            return cell
        }else {
            let cell = commentCollectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as! CommentCollectionViewCell
            
            cell.comment.text = product!.comments[indexPath.row].comment
            User().getInfoUser(product!.comments[indexPath.row].phoneNumber, completion: { info in
                cell.author.text = info.name
                cell.avatar.sd_setImage(with: URL(string: info.avatar))
            })
            let dateString = product!.comments[indexPath.row].createdAt

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
            let date = dateFormatter.date(from: dateString)

            dateFormatter.dateFormat = "dd/MM"
            if let formattedDate = date {
                let finalDate = dateFormatter.string(from: formattedDate)
                cell.createdAt.text = finalDate
            }

            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 375)
        }else {
            let text = product!.comments[indexPath.row].comment
            let width = UIScreen.main.bounds.width - 52
            let height = text.height(withConstrainedWidth: width, font: UIFont.systemFont(ofSize: 13)) + 60
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == imageCollectionView{
            pageControl.currentPage = indexPath.row
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToAccount" {
            let vc = segue.destination as! AccountViewController
            vc.userId = userId

        }
        
    }
}

extension ProductViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}
