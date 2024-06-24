//
//  ProgressView.swift
//  Intop
//
//  Created by Руслан on 20.06.2024.
//

import Foundation
import UIKit

class ProgressView: UIProgressView {
    
    static var timer = [Timer]()

    func startProgress(_ progressView:UIProgressView, seconds: Float, select: Int, finish: @escaping () -> ()) {
        ProgressView.timer[select] = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            progressView.progress += 0.01 / seconds
            if progressView.progress >= 1 {
                timer.invalidate()
                finish()
            }
        })
    }
    
    func stopProgress(select: Int) {
        ProgressView.timer[select].invalidate()
    }
    
    func createProgress() -> UIProgressView {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0
        progress.tintColor = .white
        return progress
    }
}
