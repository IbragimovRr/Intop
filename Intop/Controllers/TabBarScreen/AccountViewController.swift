
import UIKit
import SDWebImage

class AccountViewController: UIViewController {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var shopNameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subscriptionCountLbl: UILabel!
    @IBOutlet weak var subscribersCountLbl: UILabel!
    @IBOutlet weak var postsCountLbl: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var products = [Product]()
    var users: JSONUser?
    var userId: Int?
    var rating: RatingStruct?
    var like = false
    var categories = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTovar()
        addInfoUser()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        Categories().getCategories { result in
            self.categories = result
            self.categoryCollectionView.reloadData()
        }
        Tovar().getTovarByUserId(userId!) { result in
            print(result, 124981)
            self.products = result
            self.productsCollectionView.reloadData()
        }
        
        
        User().getInfoUserById("\(userId!)") { info in
            self.users = info
            self.addInfoUser()
        }
            
        
        
    }
    
    func getTovar() {
        guard let userId = userId else {return}
    }

    func addInfoUser() {
        imageUser.sd_setImage(with: URL(string: users?.avatar ?? ""))
        shopNameLbl.text = users?.shopName
        nameLbl.text = users?.name
        subscribersCountLbl.text = "\(users?.subscribers ?? 0)"
        subscriptionCountLbl.text = "\(users?.subscribers ?? 0)"
        postsCountLbl.text = "\(users?.posts ?? 0)"
    }
    
    
    @IBAction func like(_ sender: UIButton) {
        
        if like == false {
            like = true
            sender.setImage(UIImage(named: "likeFull"), for: .normal)
        }else {
            
            like = false
            sender.setImage(UIImage(named: "like 1"), for: .normal)
        }
        
    }
    
    @IBAction func settings(_ sender: UIButton) {
        
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
}
extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        }else{
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesAnAccountCollectionViewCell
            cell.lbl.text = categories[indexPath.row].name
            return cell
        }else{
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductsAnAccountCollectionViewCell
            cell.viewsCountLbl.text = "\(products[indexPath.row].viewsCount ?? 0)"
            cell.commentsCountLbl.text = "\(products[indexPath.row].commentsCount ?? 0)"
            cell.sharesCountLbl.text = "\(products[indexPath.row].sharesCount ?? 0)"
            cell.titleLbl.text = products[indexPath.row].title
            cell.likesCountLbl.text = "\(products[indexPath.row].likes ?? 0)"
            cell.image.sd_setImage(with: URL(string: products[indexPath.row].mainImages!))
            return cell
        }
        
    }
    
    
}
