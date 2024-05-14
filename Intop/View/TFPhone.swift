//
//  TFPhone.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import UIKit

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 13
        let minLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength && newString.count >= minLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "+998" {
            flag.image = UIImage(named: "uzFlag")
        }else if textField.text == "+7" {
            flag.image = UIImage(named: "rusFlag")
        }else if textField.text == "+375" {
            flag.image = UIImage(named: "belarusFlag")
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 13
        let minLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength && newString.count >= minLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "+998" {
            flag.image = UIImage(named: "uzFlag")
        }else if textField.text == "+7" {
            flag.image = UIImage(named: "rusFlag")
        }else if textField.text == "+375" {
            flag.image = UIImage(named: "belarusFlag")
        }
    }
}
