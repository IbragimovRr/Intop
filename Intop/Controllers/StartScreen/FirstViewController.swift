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
        remember()
    }
    
    func remember() {
        if UD().getCurrentUser() == true {
            performSegue(withIdentifier: "current", sender: self)
        }
        if UD().getRemember() == false {
            UD().saveSignUser(false)
        }
    }
    
    @IBAction func btn(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecond", sender: self)
    }
    

}
