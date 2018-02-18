//
//  UIButtonExtension.swift
//  buttonAddition
//
//  Created by jingyu on 2/18/18.
//  Copyright © 2018 jingyu. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func color() {
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.red.cgColor
        colorAnimation.toValue = UIColor.blue.cgColor
        colorAnimation.duration = 0.5
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = 2
        self.layer.add(colorAnimation, forKey: "ColorPulse")
    }
}
