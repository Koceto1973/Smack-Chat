//
//  LoginVC.swift
//  Smack-Chat
//
//  Created by К.К. on 7.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate  {
    
    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var infoBar: UILabel!
    
    // Variables
    var isClosable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.delegate = self
        passTxt.delegate = self
        
        setupView()
    }
    
    func setupView() {
        spinner.isHidden = true
        spinner.stopAnimating()
        infoBar.text = ""
        isClosable = true
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "user email", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
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
    
    
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        infoBar.text = ""
        isClosable = false
        
        let emailCheck = TextFieldCheckService.instance.emailCheck(email: emailTxt.text)
        if !emailCheck.0 {
            debugPrint("\n\(emailCheck.1)\n")
            infoBar.text = emailCheck.1
            isClosable = true
            return
        }
        
        let passwordCheck = TextFieldCheckService.instance.passwordCheck(password: passTxt.text)
        if !passwordCheck.0 {
            debugPrint("\n\(passwordCheck.1)\n")
            infoBar.text = passwordCheck.1
            isClosable = true
            return
        }
            
        AuthService.instance.loginUser_(email: emailTxt.text!, password: passTxt.text!) { (success, responseMessage, responseCode) in
            if responseCode == 0 {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        debugPrint("\nLogin data process error, try again.\n")
                        self.infoBar.text = "Login process error, try again."
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                })
            } else if responseCode == 1 {
                debugPrint("\nEmail/Password mismatched.\n")
                self.infoBar.text = "Email/Password mismatched."
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            } else {  // responseCode = -1
                debugPrint("\nServer response error.\n")
                self.infoBar.text = "Server response error."
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            }
        }
    }
    
    @IBAction func CreateAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func ClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
