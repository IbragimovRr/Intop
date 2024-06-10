
import UIKit
import SDWebImage

class AccountViewController: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var back: UIButton!
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
    
    var phoneNumber: String?
    var products = [Product]()
    var users: JSONUser?
    var rating: RatingStruct?
    var like = false
    var categories = [Category]()
    var me = true
    var limitProduct = 27
    var loadStatus = true
    var selectProduct = Product(productID: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSegue(withIdentifier: "loading", sender: self)
        addObserverInAccount()
        addInfo()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        searchText.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Sign().goToSign(self, completion: nil)
    }
    
    
    func addObserverInAccount() {
        NotificationCenter.default.addObserver(self, selector: #selector(pathedInfo), name: NSNotification.Name("pathedInfoAccount"), object: nil)
    }
    
    @objc func pathedInfo() {
        Task {
            try await infoAboutMe()
            let categories = try await Categories().getCategories()
            self.categories = categories
            self.categoryCollectionView.reloadData()
            
            let user = try await User().getInfoUserById("\(phoneNumber!)")
            self.users = user
            self.addInfo()
            self.design()
        }
    }
    
    func infoAboutMe() async throws {
        if me == true {
            let user = try await User().getInfoUser(User.phoneNumber)
            phoneNumber = user.phoneNumber
        }
        getProductsByUser()

    }
    
    func getProductsByUser(_ search:String = "") {
        Task{
            loadStatus = true
            let tovar = try await Tovar().getTovarByUserId(phoneNumber!, limit: limitProduct, search)
            self.products = tovar
            self.productsCollectionView.reloadData()
            loadStatus = false
        }
    }
    
    
    func design() {
        if me == true {
            chatView.isHidden = true
            contactsView.isHidden = true
            settingsBtn.isHidden = false
            back.isHidden = true
            likeBtn.isHidden = true
        }else if me == false {
            chatView.isHidden = false
            contactsView.isHidden = false
            settingsBtn.isHidden = true
            back.isHidden = false
            likeBtn.isHidden = false
        }
        if UD().getCurrentUser() == false {
            performSegue(withIdentifier: "vhod", sender: self)
        }
        imageUser.sd_setImage(with: URL(string: users?.avatar ?? ""))
        shopNameLbl.text = users?.shopDescription
        nameLbl.text = users?.shopName
        subscribersCountLbl.text = "\(users?.subscribers ?? 0)"
        subscriptionCountLbl.text = "\(users?.subscriptions ?? 0)"
        postsCountLbl.text = "\(users?.posts ?? 0)"
    }
  
    func addInfo() {
        Task {
            try await infoAboutMe()
            let categories = try await Categories().getCategories()
            self.categories = categories
            self.categoryCollectionView.reloadData()
            
            let tovar = try await Tovar().getTovarByUserId(phoneNumber!, limit: limitProduct)
            self.products = tovar
            self.productsCollectionView.reloadData()
            
            let user = try await User().getInfoUser(phoneNumber!)
            self.users = user
            self.design()
            dismiss(animated: false)
        }
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
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tap(_ sender: Any) {
        getProductsByUser(searchText.text!)
        searchText.resignFirstResponder()
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
            cell.image.sd_setImage(with: URL(string: products[indexPath.row].mainImages!))
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsCollectionView {
            selectProduct = products[indexPath.row]
            performSegue(withIdentifier: "product", sender: self)
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

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height && !loadStatus{
            loadStatus = true
            limitProduct += 27
            getProductsByUser()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            let vc = segue.destination as! AccountSettingsViewController
            vc.name = users!.shopName
            vc.biography = users!.shopDescription
        }else if segue.identifier == "product" {
            let vc = segue.destination as! ProductViewController
            vc.product.productID = selectProduct.productID
        }
    }
    
    
}
extension AccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getProductsByUser(textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
}
