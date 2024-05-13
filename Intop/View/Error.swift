//
//  ErrorAlert.swift
//  Intop
//
//  Created by Руслан on 13.05.2024.
//

import Foundation
import UIKit

class Error {
    
    func alert(_ error:String,_ viewController:UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
