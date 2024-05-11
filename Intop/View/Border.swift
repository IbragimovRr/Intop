//
//  Border.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 11.05.2024.
//

import Foundation
import UIKit


class Border: UIView {
    
    @IBInspectable var border: CGFloat = 1 {
        didSet {
            layer.borderWidth = border
        }
    }
    
    func addViewBorder(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        addViewBorder(view: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViewBorder(view: self)
    }
}
