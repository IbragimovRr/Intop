//
//  SignUpViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.05.2024.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var sellerBtn: UIButton!
    @IBOutlet weak var buyerBtn: UIButton!
    var segment: SegmentSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()

      
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let phone = phoneTF.text else {return}
        guard let password = passwordTF.text else {return}
        SignIn().signUpPhone(phoneNumber: phone, password: password)  { result, error in
            if error == nil {
                self.performSegue(withIdentifier: "code", sender: self)
            }else{
                print(error!)
            }
        }
    }
    
    @IBAction func seller(_ sender: UIButton) {
        segment?.onFirst()
    }
    
    @IBAction func buyer(_ sender: UIButton) {
        segment?.onSecond()
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
    
}
