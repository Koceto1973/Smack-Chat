//
//  CreateAccountVC.swift
//  Smack-Chat
//
//  Created by К.К. on 8.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                //print("user registered!")
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        print("user logged in with authToken \(AuthService.instance.authToken)")
                    }
                }
            }
        }
    }
    @IBAction func chooseAvatarPressed(_ sender: Any) {
    }
    @IBAction func generateBGColorPressed(_ sender: Any) {
    }
    @IBAction func ClosePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
