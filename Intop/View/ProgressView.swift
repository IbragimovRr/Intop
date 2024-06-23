//
//  ProgressView.swift
//  Intop
//
//  Created by Руслан on 20.06.2024.
//

import Foundation
import UIKit

class ProgressView: UIProgressView {
    
    var timer = Timer()

    func startProgress(_ progressView:UIProgressView, seconds: Float) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            progressView.progress += 0.01 / seconds
            if progressView.progress >= 1 {
                timer.invalidate()
            }
        })
    }
    
    func stopProgress() {
        timer.invalidate()
    }
    
    func createProgress() -> UIProgressView {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0
        progress.tintColor = .white
        return progress
    }
}
