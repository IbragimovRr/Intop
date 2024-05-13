//
//  ThirdViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 13.05.2024.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        performSegue(withIdentifier: "goToStartViewController", sender: self)
    }
    
}
