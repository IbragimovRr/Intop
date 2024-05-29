
import UIKit
import SDWebImage

class AccountViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        Tovar().getAllTovars { product in
            self.products = product
            self.productsCollectionView.reloadData()
        }
    }


   
}
extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return 5
        }else{
            return products.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesAnAccountCollectionViewCell
            return cell
        }else{
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductsCollectionViewCell
            cell.viewsLbl.text = "\(products[indexPath.row].viewsCount)"
            cell.commentsLbl.text = "\(products[indexPath.row].commentsCount)"
            cell.sharesLbl.text = "\(products[indexPath.row].sharesCount)"
            cell.titleLbl.text = products[indexPath.row].title
            cell.likesLbl.text = "\(products[indexPath.row].likes)"
            cell.image.sd_setImage(with: URL(string: products[indexPath.row].image![indexPath.row]))
            return cell
        }
        
    }

    
}
