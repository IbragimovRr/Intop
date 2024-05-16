//
//  SignUpViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.05.2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var sellerBtn: UIButton!
    @IBOutlet weak var buyerBtn: UIButton!
    var segment: SegmentSettings?
    var shopRole: ShopRole = .sellerLegal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()

      
    }
    
    @IBAction func rememberBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setImage(UIImage(named: "openBox"), for: .normal)
            UD().saveRemember(true)
        }else {
            sender.tag = 0
            sender.setImage(UIImage(named: "closeBox"), for: .normal)
            UD().saveRemember(false)
        }
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let phone = phoneTF.text else {return}
        guard let password = passwordTF.text else {return}
        Sign().signUpPhone(phoneNumber: phone, password: password, shopRole: shopRole)  { result, error in
            if error == nil {
                self.performSegue(withIdentifier: "code", sender: self)
            }else if let error = error{
                Error().alert(error, self)
            }
        }
    }
    
    @IBAction func seller(_ sender: UIButton) {
        segment?.onFirst()
        shopRole = .sellerLegal
    }
    
    @IBAction func buyer(_ sender: UIButton) {
        segment?.onSecond()
        shopRole = .buyerLegal
    }
    func design() {
        segment = SegmentSettings(firstBtn: sellerBtn, secondBtn: buyerBtn)
        segment!.cornerRadiusSegment()
        segment!.onFirst()
        phoneTF.delegate = self
    }
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        phoneTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
