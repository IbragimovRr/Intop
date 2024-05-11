//
//  Border.swift
//  Intop
//
//  Created by Ибрагимов Эльдар on 11.05.2024.
//

import Foundation
import UIKit


class Border {
    
    func addViewBorder(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
    }
}
