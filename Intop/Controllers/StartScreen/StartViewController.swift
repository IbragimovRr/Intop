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
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    

    @IBAction func back(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
}
