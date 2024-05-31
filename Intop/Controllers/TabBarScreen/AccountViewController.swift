
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInfoUser()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        User().getInfoUserById("\(userId!)") { info in
            self.users = info
            self.addInfoUser()
        }
            
        
        
    }

    func addInfoUser() {
        imageUser.sd_setImage(with: URL(string: users?.avatar ?? ""))
        shopNameLbl.text = users?.shopName
        nameLbl.text = users?.name
        subscribersCountLbl.text = "\(users?.subscribers ?? 0)"
        subscriptionCountLbl.text = "\(users?.subscribers ?? 0)"
        postsCountLbl.text = "\(users?.posts ?? 0)"
        
        
    }
   
}
extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return 5
        }else{
            return products.count
           
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesAnAccountCollectionViewCell
            return cell
        }else{
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductsAnAccountCollectionViewCell
            cell.viewsLbl.text = "\(products[indexPath.row].viewsCount ?? 0)"
            cell.commentsLbl.text = "\(products[indexPath.row].commentsCount ?? 0)"
            cell.sharesLbl.text = "\(products[indexPath.row].sharesCount ?? 0)"
            cell.titleLbl.text = products[indexPath.row].title
            cell.likesLbl.text = "\(products[indexPath.row].likes ?? 0)"
            cell.image.sd_setImage(with: URL(string: products[indexPath.row].image![indexPath.row]))
            return cell
        }
        
    }
    
}
