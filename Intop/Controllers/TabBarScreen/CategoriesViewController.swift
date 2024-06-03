//
//  CategoriesViewController.swift
//  Intop
//
//  Created by Руслан on 22.05.2024.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var vieww: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = UIImage.gradientImage(bounds: vieww.bounds, colors: [.systemBlue, .systemRed])
        let gradientColor = UIColor(patternImage: gradient)
        vieww.layer.borderColor = gradientColor.cgColor
        vieww.layer.borderWidth = 3
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Sign().goToSign(self, completion: nil)
    }


}
