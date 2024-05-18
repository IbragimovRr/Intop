//
//  FirstViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 11.05.2024.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btn(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecond", sender: self)
    }
    

}
