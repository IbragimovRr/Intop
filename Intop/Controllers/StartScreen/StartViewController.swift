//
//  StartViewController.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 11.05.2024.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var viewNumber: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Border().addViewBorder(view: viewNumber)
        
    }
    

    @IBAction func back(_ sender: Any) {
        
    }
    
}
