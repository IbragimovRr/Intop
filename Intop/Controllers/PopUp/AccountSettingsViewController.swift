//
//  AccountSettingsViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 04.06.2024.
//

import UIKit

class AccountSettingsViewController: UIViewController {
    
    @IBOutlet weak var roleView: UIView!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var biographyTextField: UITextField!
    
    var country: String?
    var role: ShopRole?
    var biography = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roleView.isHidden = true
        design()
        nameTextField.delegate = self
        biographyTextField.delegate = self
        

    }
    
    
    func design() {
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
        biographyTextField.text = biography
        nameTextField.text = name
    }
    
    @IBAction func roleBtn(_ sender: UIButton) {
        if roleView.isHidden == true {
            roleView.isHidden = false
        }else {
            roleView.isHidden = true
        }
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("pathedInfoAccount"), object: nil)
        dismiss(animated: false)
    }
    
    @IBAction func selectRole(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            role = .sellerIndividual
            roleLbl.text = "Продавец физ лицо"
        case 1:
            role = .sellerIndividual
            roleLbl.text = "Продавец физ лицо"
        case 2:
            role = .sellerIndividual
            roleLbl.text = "Продавец физ лицо"
        case 3:
            role = .sellerIndividual
            roleLbl.text = "Продавец физ лицо"
        default:
            break
        }
        UD().saveShopRole(role!.rawValue)
        roleView.isHidden = true
    }
    
    @IBAction func tap(_ sender: Any) {
        biographyTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
}
extension AccountSettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            User().patchUserSettings(phoneNumber: User.phoneNumber, shopName: nameTextField.text!, shopDescription: biographyTextField.text!, shopRole: role ?? .buyerIndividual)
        }else {
            User().patchUserSettings(phoneNumber: User.phoneNumber, shopName: nameTextField.text!, shopDescription: biographyTextField.text!, shopRole: role ?? .buyerIndividual)
        }
    }
}
