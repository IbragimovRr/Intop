//
//  CodeTF.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import UIKit

extension CodeVerificationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        if textField.text == ""{
            textField.text = " "
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !(string == "") {
            textField.text = string
            if textField == firstTF {
                secondTF.becomeFirstResponder()
            }
            else if textField == secondTF {
                thirdTF.becomeFirstResponder()
            }
            else if textField == thirdTF {
                fourthTF.becomeFirstResponder()
            }
            else if textField == fourthTF {
                fivethTF.becomeFirstResponder()
            }
            else if textField == fivethTF {
                sixthTF.becomeFirstResponder()
            }
            else {
                let code = firstTF.text! + secondTF.text! + thirdTF.text! + fourthTF.text! + fivethTF.text! + sixthTF.text!
                //authUser(code: code)
                
            }
            return false
        }else{
            textField.text = string
            if textField == secondTF {
                firstTF.becomeFirstResponder()
            }
            else if textField == thirdTF {
                secondTF.becomeFirstResponder()
            }
            else if textField == fourthTF {
                thirdTF.becomeFirstResponder()
            }
            else if textField == fivethTF {
                fourthTF.becomeFirstResponder()
            }
            else if textField == sixthTF {
                fivethTF.becomeFirstResponder()
            }
            
            return false
        }
    }
}
