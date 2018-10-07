//
//  ChannelVC.swift
//  Smack-Chat
//
//  Created by К.К. on 7.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rear view takes all but 60 points
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }
}
