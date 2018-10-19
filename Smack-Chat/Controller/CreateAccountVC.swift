//
//  CreateAccountVC.swift
//  Smack-Chat
//
//  Created by К.К. on 8.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var infoBar: UILabel!
    
    // Variables
    var isClosable: Bool = true
    var avatarName: String = ""
    var avatarColor: String = ""
    var bgColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // text fields setup
        usernameTxt.delegate = self
        emailTxt.delegate = self
        passTxt.delegate = self
        
        // precaution for closed view of CreateAccountVC after avatar is picked
        UserDataService.instance.setAvatarName(avatarName: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isClosable = true
        infoBar.text = ""
        spinner.isHidden = true
        avatarName = "profileDefault"
        avatarColor = "[0.5, 0.5, 0.5, 1]"
        
        // placeholders setup
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName )
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    // textfields keyboard dismissal by side touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // textfields keyboard dismissal by return key
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let username  = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        AuthService.instance.registerUser_(email: email, password: pass){ (success,responseMessage,responseCode) in
            if success {
                
            }
        }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion:
                    { (success) in
                    if success {
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion:
                            { (success) in
                            if success {
                                
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.5) {
            self.userImg.backgroundColor = self.bgColor
        }
        
        avatarColor = "[\(r),\(g),\(b),1]"  // ready for user creation
        
    }
   
    @IBAction func ClosePressed(_ sender: Any) {
        if isClosable {
            performSegue(withIdentifier: UNWIND, sender: nil)
        } else {
            infoBar.text = "Close button is temporarily disabled."
        }
    }
}

