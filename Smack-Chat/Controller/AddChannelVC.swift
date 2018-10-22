//
//  AddChannelVC.swift
//  Smack-Chat
//
//  Created by К.К. on 18.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var channelNameText: UITextField!
    @IBOutlet weak var channelDescriptionText: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        channelNameText.delegate = self
        channelDescriptionText.delegate = self
        
        setupView()
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        channelNameText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        
        channelDescriptionText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
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
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = channelNameText.text, channelNameText.text != "" else {return}
        guard let channelDescription = channelDescriptionText.text, channelDescriptionText.text != "" else {return}
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        closeModalPressed(_:AnyObject.self)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
