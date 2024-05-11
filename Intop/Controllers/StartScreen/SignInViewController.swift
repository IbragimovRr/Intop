//
//  SignInViewController.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var buyerBtn: UIButton!
    @IBOutlet weak var sellerBtn: UIButton!
    var segment: SegmentSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        
    }
    
    @IBAction func SignInBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: self)
    }
    @IBAction func registrBtn(_ sender: UIButton) {
        
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
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        phoneTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
}
