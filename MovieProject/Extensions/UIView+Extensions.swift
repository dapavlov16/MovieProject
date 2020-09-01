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
        
        let animations: (() -> Void) = { self.alpha = 1 }
        
        isHidden = false
        if duration <= 0 {
            animations()
            onComplete?(true)
        } else {
            UIView.animate(withDuration: duration, animations: animations, completion: onComplete)
        }
    }
    
    func fadeOut(withDuration duration: TimeInterval, onComplete: ((Bool) -> Void)? = nil) {
        
        let animations: (() -> Void) = { self.alpha = 0 }
        let completion: ((Bool) -> Void) = { completed in
            self.isHidden = completed
            onComplete?(completed)
        }
        
        if duration <= 0 {
            animations()
            completion(true)
        } else {
            UIView.animate(withDuration: duration, animations: animations, completion: completion)
        }
    }
    
    func dropShadow(opacity: Float = 1,
                    radius: CGFloat = 3,
                    offset: CGSize = CGSize(width: 0, height: -3),
                    color: CGColor = UIColor.black.cgColor) {
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
