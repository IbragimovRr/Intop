//
//  AccountSettingsViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 04.06.2024.
//

import UIKit

class AccountSettingsViewController: UIViewController {

    var country: String?
    var role: ShopRole?
    var name: String?
    var biography: String?
    
    @IBOutlet weak var roleView: UIView!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var biographyTextField: UITextField!
    
    override func viewDidLoad() {
        roleView.isHidden = true
        design()
        super.viewDidLoad()
        nameTextField.delegate = self
        biographyTextField.delegate = self
        

    }
    
    
    func design() {
        nameTextField.text = name
        biographyTextField.text = biography
        roleLbl.text = UD().getShopRole()
        if roleLbl.text == "seller_individual" {
            roleLbl.text = "Продавец физ лицо"
        }else if roleLbl.text == "seller_legal" {
            roleLbl.text = "Продавец юр лицо"
        }else if roleLbl.text == "buyer_individual" {
            roleLbl.text = "Покупатель физ лицо"
        }else if roleLbl.text == "buyer_legal" {
            roleLbl.text = "Покупатель юр лицо"
        }
    }
    
    @IBAction func roleBtn(_ sender: UIButton) {
        if roleView.isHidden == true {
            roleView.isHidden = false
        }else {
            roleView.isHidden = true
        }
        
    }
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: false)
    }
    @IBAction func sellerFiz(_ sender: UIButton) {
        role = .sellerIndividual
        roleLbl.text = "Продавец физ лицо"
        UD().saveShopRole(role!.rawValue)
    }
    @IBAction func sellerUr(_ sender: UIButton) {
        role = .sellerLegal
        roleLbl.text = "Продавец юр лицо"
        UD().saveShopRole(role!.rawValue)
    }
    @IBAction func buyerFiz(_ sender: UIButton) {
        role = .buyerIndividual
        roleLbl.text = "Покупатель физ лицо"
        UD().saveShopRole(role!.rawValue)
    }
    @IBAction func buyerUr(_ sender: UIButton) {
        role = .buyerLegal
        roleLbl.text = "Покупатель юр лицо"
        UD().saveShopRole(role!.rawValue)
    }

    
    
}
extension AccountSettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            User().patchUserSettings(phoneNumber: User.phoneNumber, shopName: nameTextField.text ?? "", shopDescription: biographyTextField.text ?? "", shopRole: role ?? .buyerIndividual)
        }else {
            User().patchUserSettings(phoneNumber: User.phoneNumber, shopName: nameTextField.text ?? "", shopDescription: biographyTextField.text ?? "", shopRole: role ?? .buyerIndividual)
        }
    }
}
