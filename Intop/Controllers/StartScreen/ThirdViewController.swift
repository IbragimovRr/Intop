//
//  ThirdViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.05.2024.
//

import UIKit

class ThirdViewController: UIViewController {

    var current:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        current = true
        performSegue(withIdentifier: "goToTabBar", sender: self)
        UD().saveCurrentUser(current)
    }
    
}
