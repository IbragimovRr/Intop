//
//  SignInViewController.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var flag: UIImageView!
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
        guard let phone = phoneTF.text else { return }
        guard let password = passwordTF.text else { return }
        guard let segment = segment else { return }
        Task {
            do {
                let result = try await Sign().signInPhone(phoneNumber: phone, password: password, isSeller: segment.isSeller)
                self.performSegue(withIdentifier: "code", sender: self)
            }catch let error as ErrorSignIn {
                DispatchQueue.main.async {
                    Error().alert(error.rawValue, self)
                }
            }catch {
                DispatchQueue.main.async {
                    Error().alert(ErrorSignIn.tryAgainLater.rawValue, self)
                }
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
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
}
