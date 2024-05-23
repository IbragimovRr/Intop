//
//  Segment.swift
//  Intop
//
//  Created by Руслан on 11.05.2024.
//

import Foundation
import UIKit

protocol Segment {
    var firstBtn:UIButton { get set }
    var secondBtn:UIButton { get set }
    
    func onFirst()
    func onSecond()
}

class SegmentSettings:Segment {
    
    
    var firstBtn:UIButton = UIButton()
    var secondBtn:UIButton = UIButton()
    var isSeller: Bool = true
    
    
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
        isSeller = true
    }
    
    func onSecond() {
        secondBtn.backgroundColor = UIColor(named: "OrangeMain")
        secondBtn.setTitleColor(UIColor.white, for: .normal)
        firstBtn.backgroundColor = UIColor(named: "BorderColor")
        firstBtn.setTitleColor(UIColor.black, for: .normal)
        isSeller = false
    }
    
    init(firstBtn: UIButton!, secondBtn: UIButton!) {
        self.firstBtn = firstBtn
        self.secondBtn = secondBtn
    }
}

class SegmentFilter:Segment {
    var firstBtn: UIButton = UIButton()
    
    var secondBtn: UIButton = UIButton()
    var select: SegmentInst = .instagram
    
    func onFirst() {
        firstBtn.setImage(UIImage(named: "instagramFull"), for: .normal)
        secondBtn.setImage(UIImage(named: "multimedia"), for: .normal)
        select = .instagram
    }
    
    func onSecond() {
        firstBtn.setImage(UIImage(named: "instagram"), for: .normal)
        secondBtn.setImage(UIImage(named: "multimediaFull"), for: .normal)
        select = .multimedia
    }
    
    init(firstBtn: UIButton!, secondBtn: UIButton!) {
        self.firstBtn = firstBtn
        self.secondBtn = secondBtn
    }
}
