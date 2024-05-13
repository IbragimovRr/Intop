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
        let minLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength && newString.count >= minLength
    }
}
