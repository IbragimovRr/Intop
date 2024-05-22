//
//  CodeVerificationViewController.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import UIKit

class CodeVerificationViewController: UIViewController {
    
    @IBOutlet weak var sixthTF: UITextField!
    @IBOutlet weak var fivethTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var firstTF: UITextField!
    
    var codeInScreen: String {
        return firstTF.text! + secondTF.text! + thirdTF.text! + fourthTF.text! + fivethTF.text! + sixthTF.text!
    }
    var code = ""
    var timeRestart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTF.delegate = self
        secondTF.delegate = self
        thirdTF.delegate = self
        fourthTF.delegate = self
        fivethTF.delegate = self
        sixthTF.delegate = self
        sendCode()
    }
    
    func sendCode() {
        guard let phoneNumber = UD().getPhone() else { return }
        Sign().sendCode(phoneNumber) { code in
            self.code = code
        }
    }
    
    @IBAction func restartCode(_ sender: UIButton) {
        if timeRestart == 0 {
            sendCode()
        }else{
            Error().alert("Слишком часто. Следующий раз можно попробовать через \(timeRestart) секунд", self)
            return
        }
        timeRestart = 60
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timeRestart -= 1
            if self.timeRestart == 0 {
                timer.invalidate()
            }
        }
    }
    
    @IBAction func sendBtn(_ sender: UIButton) {
        if code == codeInScreen {
            UD().saveSignUser(true)
            performSegue(withIdentifier: "succes", sender: self)
        }else {
            Error().alert("Неправильный код", self)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        firstTF.resignFirstResponder()
        secondTF.resignFirstResponder()
        thirdTF.resignFirstResponder()
        fourthTF.resignFirstResponder()
        fivethTF.resignFirstResponder()
    }
}
