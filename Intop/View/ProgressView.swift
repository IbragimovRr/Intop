//
//  ProgressView.swift
//  Intop
//
//  Created by Руслан on 20.06.2024.
//

import Foundation
import UIKit

extension UIProgressView {
    
    func animate(_ seconds: Float, finish: @escaping () -> ()) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.progress += 0.01 / seconds
            if self.progress >= 1.0 {
                timer.invalidate()
                finish()
            }
        }
    }
}
