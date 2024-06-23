//
//  ProgressView.swift
//  Intop
//
//  Created by Руслан on 20.06.2024.
//

import Foundation
import UIKit

private var progressTimerKey: UInt8 = 0

extension UIProgressView {
    private var timer: Timer? {
        get {
            return objc_getAssociatedObject(self, &progressTimerKey) as? Timer
        }
        set {
            objc_setAssociatedObject(self, &progressTimerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func animate(_ seconds: Float, finish: @escaping () -> ()) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.progress += 0.01 / seconds
            if self.progress >= 1.0 {
                timer.invalidate()
                finish()
            }
        }
    }
    func start(_ seconds: Float) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.progress += 0.01 / seconds
            if self.progress >= 1.0 {
                timer.invalidate()
            }
        }
    }
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
