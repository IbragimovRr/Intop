//
//  FilterViewController.swift
//  Intop
//
//  Created by Руслан on 27.05.2024.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var notVerify: UIButton!
    @IBOutlet weak var verify: UIButton!
    @IBOutlet weak var old: UIButton!
    @IBOutlet weak var new: UIButton!
    @IBOutlet weak var roznica: UIButton!
    @IBOutlet weak var opt: UIButton!
    @IBOutlet weak var rasrochka: UIButton!
    @IBOutlet weak var valutaUSD: UIButton!
    @IBOutlet weak var valutaUZS: UIButton!
    @IBOutlet weak var torg: UIButton!
    @IBOutlet weak var priceDo: UITextField!
    @IBOutlet weak var priceOt: UITextField!
    @IBOutlet weak var blisko: UIButton!
    @IBOutlet weak var upMoney: UIButton!
    @IBOutlet weak var downMoney: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onFirst(_ sender: UIButton) {
    }
    
    @IBAction func onSecond(_ sender: UIButton) {
    }
    
    @IBAction func start(_ sender: UIButton) {
        
    }
    
    @IBAction func sbros(_ sender: UIButton) {
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false)
    }
}
