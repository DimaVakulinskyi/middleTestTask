//
//  Debouncer.swift
//  middleTestTask
//
//  Created by Dmytro Vakulinsky on 10.05.2023.
//

import Foundation
import Combine

class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func schedule(action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}
