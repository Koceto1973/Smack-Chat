//
//  GradientView.swift
//  Smack-Chat
//
//  Created by К.К. on 7.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

@IBDesignable // rendering inside storyboard on Project/ Build
class GradientView: UIView {
    
    @IBInspectable var topColor:UIColor = UIColor.blue {
        didSet { // when defined item is amended in storyboard, view reload is triggered
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor:UIColor = UIColor.green {
        didSet { // when defined item is amended in storyboard, view reload is triggered
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor] // might be longer sequence of colors
        // gradient line is defined and may be customized
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0) // 0 at first layer
        
        
        
    }
    
}
