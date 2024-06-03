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

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}
