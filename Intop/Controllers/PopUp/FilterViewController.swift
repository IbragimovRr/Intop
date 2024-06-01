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
    
    var segmentTorg = false
    var segmentBlisko = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSbros()
    }
    
    func designAction(_ actionBtn:UIButton,_ secondBtn:UIButton,_ thirdBtn:UIButton = UIButton()) {
        actionBtn.setTitleColor(UIColor.white, for: .normal)
        actionBtn.backgroundColor = UIColor(named: "OrangeMain")
        actionBtn.layer.borderColor = UIColor.clear.cgColor
        secondBtn.setTitleColor(UIColor.black, for: .normal)
        secondBtn.backgroundColor = UIColor.clear
        secondBtn.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        secondBtn.layer.borderWidth = 1.5
        thirdBtn.setTitleColor(UIColor.black, for: .normal)
        thirdBtn.backgroundColor = UIColor.clear
        thirdBtn.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        thirdBtn.layer.borderWidth = 1.5
    }
    
    func designSbros() {
        notVerify.setTitleColor(UIColor.black, for: .normal)
        notVerify.backgroundColor = UIColor.clear
        verify.setTitleColor(UIColor.black, for: .normal)
        verify.backgroundColor = UIColor.clear
        old.setTitleColor(UIColor.black, for: .normal)
        old.backgroundColor = UIColor.clear
        new.setTitleColor(UIColor.black, for: .normal)
        new.backgroundColor = UIColor.clear
        roznica.setTitleColor(UIColor.black, for: .normal)
        roznica.backgroundColor = UIColor.clear
        opt.setTitleColor(UIColor.black, for: .normal)
        opt.backgroundColor = UIColor.clear
        rasrochka.setTitleColor(UIColor.black, for: .normal)
        rasrochka.backgroundColor = UIColor.clear
        valutaUSD.setTitleColor(UIColor.black, for: .normal)
        valutaUSD.backgroundColor = UIColor.clear
        valutaUZS.setTitleColor(UIColor.black, for: .normal)
        valutaUZS.backgroundColor = UIColor.clear
        upMoney.setTitleColor(UIColor.black, for: .normal)
        upMoney.backgroundColor = UIColor.clear
        downMoney.setTitleColor(UIColor.black, for: .normal)
        downMoney.backgroundColor = UIColor.clear
        notVerify.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        verify.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        old.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        new.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        roznica.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        opt.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        rasrochka.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        valutaUSD.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        valutaUZS.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        upMoney.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        downMoney.layer.borderColor = UIColor(named: "BorderGray")!.cgColor
        notVerify.layer.borderWidth = 1.5
        verify.layer.borderWidth = 1.5
        old.layer.borderWidth = 1.5
        new.layer.borderWidth = 1.5
        roznica.layer.borderWidth = 1.5
        opt.layer.borderWidth = 1.5
        rasrochka.layer.borderWidth = 1.5
        valutaUSD.layer.borderWidth = 1.5
        valutaUZS.layer.borderWidth = 1.5
        upMoney.layer.borderWidth = 1.5
        downMoney.layer.borderWidth = 1.5
    }
    
    @IBAction func onFirst(_ sender: UIButton) {
        switch sender.tag {
        case downMoney.tag:
            Filter.isAscending = true
            designAction(downMoney, upMoney)
        case valutaUZS.tag:
            Filter.valuta = "UZS"
            designAction(valutaUZS, valutaUSD)
        case rasrochka.tag:
            designAction(rasrochka, opt, roznica)
        case new.tag:
            Filter.isNew = true
            designAction(new, old)
        case verify.tag:
            Filter.isSellerVerified = true
            designAction(verify, notVerify)
        default:
            break
        }
    }
    
    @IBAction func onSecond(_ sender: UIButton) {
        switch sender.tag {
        case upMoney.tag:
            Filter.isAscending = false
            designAction(upMoney, downMoney)
        case valutaUSD.tag:
            Filter.valuta = "USD"
            designAction(valutaUSD, valutaUZS)
        case opt.tag:
            designAction(opt, rasrochka, roznica)
        case old.tag:
            Filter.isNew = false
            designAction(old, new)
        case notVerify.tag:
            Filter.isSellerVerified = false
            designAction(notVerify, verify)
        default:
            break
        }
    }
    
    @IBAction func onThird(_ sender: UIButton) {
        designAction(roznica, opt, rasrochka)
    }
    
    
    @IBAction func switchBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            if segmentBlisko == true {
                Filter.isNearby = false
                sender.setImage(UIImage(named: "switchOff"), for: .normal)
                segmentBlisko = false
            }else {
                Filter.isNearby = true
                sender.setImage(UIImage(named: "switchOn"), for: .normal)
                segmentBlisko = true
            }
        }else {
            if segmentTorg == true {
                Filter.isNegotiable = false
                sender.setImage(UIImage(named: "switchOff"), for: .normal)
                segmentTorg = false
            }else {
                Filter.isNegotiable = true
                sender.setImage(UIImage(named: "switchOn"), for: .normal)
                segmentTorg = true
            }
        }
    }
    
    @IBAction func start(_ sender: UIButton) {
        
    }
    
    @IBAction func sbros(_ sender: UIButton) {
        Filter.isAscending = nil
        Filter.isNearby = nil
        Filter.isNegotiable = nil
        Filter.isNew = nil
        Filter.isSellerVerified = nil
        Filter.priceDo = nil
        Filter.priceOt = nil
        Filter.valuta = nil
        designSbros()
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        priceDo.resignFirstResponder()
        priceOt.resignFirstResponder()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false)
    }
}
