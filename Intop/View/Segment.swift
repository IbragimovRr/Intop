//
//  Segment.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import Foundation
import UIKit



class SegmentSettings {
    
    var firstBtn:UIButton!
    var secondBtn:UIButton!
    
    func cornerRadiusSegment() {
        firstBtn.clipsToBounds = true
        firstBtn.layer.cornerRadius = 7
        firstBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        secondBtn.clipsToBounds = true
        secondBtn.layer.cornerRadius = 7
        secondBtn.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
    
    func onFirst() {
        firstBtn.backgroundColor = UIColor(named: "OrangeMain")
        firstBtn.setTitleColor(UIColor.white, for: .normal)
        secondBtn.backgroundColor = UIColor(named: "BorderColor")
        secondBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
    func onSecond() {
        secondBtn.backgroundColor = UIColor(named: "OrangeMain")
        secondBtn.setTitleColor(UIColor.white, for: .normal)
        firstBtn.backgroundColor = UIColor(named: "BorderColor")
        firstBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
    init(firstBtn: UIButton!, secondBtn: UIButton!) {
        self.firstBtn = firstBtn
        self.secondBtn = secondBtn
    }
}
