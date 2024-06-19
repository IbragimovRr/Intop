//
//  AccountSettingsViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 04.06.2024.
//

import UIKit


class AccountSettingsViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sellerIndividualBtn: UIButton!
    @IBOutlet weak var sellerLegalBtn: UIButton!
    @IBOutlet weak var buyerIndividualBtn: UIButton!
    @IBOutlet weak var buyerLegalBtn: UIButton!
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
        
        selectedRole()
        roleView.isHidden = true
        design()
        nameTextField.delegate = self
        biographyTextField.delegate = self
        

    }
    
    func selectedRole() {
        if UD().getShopRole() == "seller_individual" {
            sellerIndividualBtn.backgroundColor = .orange
            sellerIndividualBtn.setTitleColor(.white, for: .normal)
        }else if UD().getShopRole() == "seller_legal" {
            sellerLegalBtn.backgroundColor = .orange
            sellerLegalBtn.setTitleColor(.white, for: .normal)
        }else if UD().getShopRole() == "buyer_individual" {
            buyerIndividualBtn.backgroundColor = .orange
            buyerIndividualBtn.setTitleColor(.white, for: .normal)
        }else if UD().getShopRole() == "buyer_legal" {
            buyerLegalBtn.backgroundColor = .orange
            buyerLegalBtn.setTitleColor(.white, for: .normal)
        }
    }
    
    func changeButtons(btn: UIButton, otherBtns: [UIButton]) {
        btn.backgroundColor = .orange
        btn.setTitleColor(.white, for: .normal)
        for x in 0 ... otherBtns.count - 1{
            otherBtns[x].backgroundColor = .white
            otherBtns[x].setTitleColor(.black, for: .normal)
        }
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
        dismiss(animated: false)
    }
    
    @IBAction func acceptBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("pathedInfoAccount"), object: nil)
        dismiss(animated: false)
    }
    @IBAction func selectRole(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            role = .sellerIndividual
            roleLbl.text = "Продавец физ лицо"
            sender.backgroundColor = UIColor(named: "OrangeMain")
            changeButtons(btn: sellerIndividualBtn, otherBtns: [sellerLegalBtn, buyerLegalBtn, buyerIndividualBtn])
        case 1:
            role = .sellerLegal
            roleLbl.text = "Продавец юр лицо"
            sender.backgroundColor = UIColor(named: "OrangeMain")
            changeButtons(btn: sellerLegalBtn, otherBtns: [sellerIndividualBtn, buyerIndividualBtn, buyerLegalBtn])
        case 2:
            role = .buyerIndividual
            roleLbl.text = "Покупатель физ лицо"
            sender.backgroundColor = UIColor(named: "OrangeMain")
            changeButtons(btn: buyerIndividualBtn, otherBtns: [buyerLegalBtn, sellerIndividualBtn, sellerLegalBtn])
        case 3:
            role = .buyerLegal
            roleLbl.text = "Покупатель юр лицо"
            sender.backgroundColor = UIColor(named: "OrangeMain")
            changeButtons(btn: buyerLegalBtn, otherBtns: [buyerIndividualBtn, sellerIndividualBtn, sellerLegalBtn])
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
