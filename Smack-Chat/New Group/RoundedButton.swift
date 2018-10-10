//
//  RoundedButton.swift
//  Smack-Chat
//
//  Created by К.К. on 10.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

@IBDesignable                       // to see changes in storyboard
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 3.0 {
        didSet { // what happens if we change it in storyboard
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()    // custom building method instead of super.awakeFromNib()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }

}
