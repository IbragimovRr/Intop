
import UIKit
import SDWebImage

class AccountViewController: UIViewController {

    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var contactsView: UIView!
    @IBOutlet weak var chatView: UIView!
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
    var me = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        design()
        addInfoUser()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        Task {
            let categories = try await Categories().getCategories()
            self.categories = categories
            self.categoryCollectionView.reloadData()
            
            let tovar = try await Tovar().getTovarByUserId(userId!)
            self.products = tovar
            self.productsCollectionView.reloadData()
            
            
            let user = try await User().getInfoUserById("\(userId!)")
            self.users = user
            self.addInfoUser()
        }
            
        
        
    }
    
    func design() {
        if me == true {
            chatView.isHidden = true
            contactsView.isHidden = true
            settingsBtn.isHidden = false
        }else if me == false {
            chatView.isHidden = false
            contactsView.isHidden = false
            settingsBtn.isHidden = true
        }
    }
    

    func addInfoUser() {
        imageUser.sd_setImage(with: URL(string: users?.avatar ?? ""))
        shopNameLbl.text = users?.shopName
        nameLbl.text = users?.name
        subscribersCountLbl.text = "\(users?.subscribers ?? 0)"
        subscriptionCountLbl.text = "\(users?.subscriptions ?? 0)"
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
//            cell.viewsCountLbl.text = "\(products[indexPath.row].viewsCount ?? 0)"
//            cell.commentsCountLbl.text = "\(products[indexPath.row].commentsCount ?? 0)"
//            cell.sharesCountLbl.text = "\(products[indexPath.row].sharesCount ?? 0)"
//            cell.titleLbl.text = products[indexPath.row].title
//            cell.likesCountLbl.text = "\(products[indexPath.row].likes ?? 0)"
            cell.image.sd_setImage(with: URL(string: products[indexPath.row].mainImages!))
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productsCollectionView {
            let width = UIScreen.main.bounds.width / 3 
            return CGSize(width: width, height: width)
        }else {
            return CGSize(width: 71, height: 29)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            let vc = segue.destination as! AccountSettingsViewController
            vc.nameTextField.text = users?.name
            vc.nameTextField.text = users?.shopName
        }
    }
}
