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
        designStart()
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
        priceDo.text = ""
        priceOt.text = ""
    }
    
    func designStart() {
        if Filter.priceDo != nil{
            priceDo.text = "\(Filter.priceDo!)"
        }
        if Filter.priceOt != nil {
            priceOt.text = "\(Filter.priceOt!)"
        }
        if Filter.isAscending == true {
            firstSelected(tag: downMoney.tag)
        }else if Filter.isAscending == false  {
            secondSelected(tag: upMoney.tag)
        }
        if Filter.valuta == "UZS" {
            firstSelected(tag: valutaUZS.tag)
        }else if Filter.valuta == "USD" {
            secondSelected(tag: valutaUSD.tag)
        }
        if Filter.isNew == true{
            firstSelected(tag: new.tag)
        }else if Filter.isNew == false{
            secondSelected(tag: old.tag)
        }
        if Filter.isSellerVerified == true{
            firstSelected(tag: verify.tag)
        }else if Filter.isSellerVerified == false {
            secondSelected(tag: notVerify.tag)
        }
        if Filter.isNearby == false {
            blisko.setImage(UIImage(named: "switchOff"), for: .normal)
            segmentBlisko = false
        }else if Filter.isNearby == true {
            blisko.setImage(UIImage(named: "switchOn"), for: .normal)
            segmentBlisko = true
        }
        if Filter.isNegotiable == false {
            torg.setImage(UIImage(named: "switchOff"), for: .normal)
            segmentTorg = false
        }else if Filter.isNegotiable == true {
            torg.setImage(UIImage(named: "switchOn"), for: .normal)
            segmentTorg = true
        }
        
        if Filter.opt == true {
            secondSelected(tag: opt.tag)
        }else if Filter.rasrochka == true {
            firstSelected(tag: rasrochka.tag)
        }else if Filter.roznica == true {
            thirdSelect()
        }
    }
    
    func firstSelected(tag:Int) {
        switch tag {
        case downMoney.tag:
            Filter.isAscending = true
            designAction(downMoney, upMoney)
        case valutaUZS.tag:
            Filter.valuta = "UZS"
            designAction(valutaUZS, valutaUSD)
        case rasrochka.tag:
            Filter.opt = nil
            Filter.roznica = nil
            Filter.rasrochka = true
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
    
    func secondSelected(tag:Int) {
        switch tag {
        case upMoney.tag:
            Filter.isAscending = false
            designAction(upMoney, downMoney)
        case valutaUSD.tag:
            Filter.valuta = "USD"
            designAction(valutaUSD, valutaUZS)
        case opt.tag:
            Filter.opt = true
            Filter.roznica = nil
            Filter.rasrochka = nil
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
    
    func thirdSelect() {
        Filter.opt = nil
        Filter.roznica = true
        Filter.rasrochka = nil
        designAction(roznica, opt, rasrochka)
    }
    
    @IBAction func onFirst(_ sender: UIButton) { firstSelected(tag: sender.tag) }
    
    
    
    @IBAction func onSecond(_ sender: UIButton) { secondSelected(tag: sender.tag) }
    
    @IBAction func onThird(_ sender: UIButton) { thirdSelect() }
    
    
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
        Filter.priceDo = Int(priceDo.text ?? "")
        Filter.priceOt = Int(priceOt.text ?? "")
        dismiss(animated: false) {
            NotificationCenter.default.post(name: Notification.Name("filterReloadTovars"), object: nil)
        }
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
        Filter.opt = nil
        Filter.rasrochka = nil
        Filter.roznica = nil
        designSbros()
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        priceDo.resignFirstResponder()
        priceOt.resignFirstResponder()
    }
    
    @IBAction func back(_ sender: Any) {
        designSbros()
        dismiss(animated: false)
    }
}
