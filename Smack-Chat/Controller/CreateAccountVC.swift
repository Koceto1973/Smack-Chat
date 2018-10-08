//
//  CreateAccountVC.swift
//  Smack-Chat
//
//  Created by К.К. on 8.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func ClosePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
