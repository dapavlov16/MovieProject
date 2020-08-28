//
//  UIView+Extensions.swift
//  MovieProject
//
//  Created by Дмитрий Павлов on 28.08.2020.
//  Copyright © 2020 Дмитрий Павлов. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeIn(withDuration duration: TimeInterval, onComplete: ((Bool) -> Void)? = nil) {
        self.isHidden = false
        
        if duration <= 0 {
            self.alpha = 1
            return
        }
        self.alpha = 0
        
        UIView.animate(withDuration: duration,
                       animations: { self.alpha = 1 },
                       completion: onComplete)
    }
    
    func fadeOut(withDuration duration: TimeInterval, onComplete: ((Bool) -> Void)? = nil) {
        if duration <= 0 {
            self.alpha = 0
            self.isHidden = true
            return
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) { completed in
            self.isHidden = true
            if let onComplete = onComplete {
                onComplete(completed)
            }
        }
    }
}
