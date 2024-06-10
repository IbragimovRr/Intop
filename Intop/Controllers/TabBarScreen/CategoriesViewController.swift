//
//  CategoriesViewController.swift
//  Intop
//
//  Created by Руслан on 22.05.2024.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoriesViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Sign().goToSign(self, completion: nil)
    }


}
