//
//  SuccesViewController.swift
//  Intop
//
//  Created by Руслан on 14.05.2024.
//

import UIKit

class SuccesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "start", sender: self)
    }
    

}
