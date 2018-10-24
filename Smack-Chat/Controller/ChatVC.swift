//
//  ChatVC.swift
//  Smack-Chat
//
//  Created by К.К. on 7.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // accomodating longer messages
        // first set number of message label lines to zero
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        sendButton.isHidden = true
        
        // message keyboard shifter up
        view.bindToKeyboard()
        // message keyboard shifter down
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        // more functionality to the menu button
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (success) in
            if success {
                self.tableView.reloadData()
                // scroll to bottom
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        if AuthService.instance.isLoggedIn {
                print("\n someone with email \n \(AuthService.instance.userEmail) \n and authToken \n \(AuthService.instance.authToken) \n is logged in \n")
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    @objc func userDataDidChange(_ notif:Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please, log in."
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notification: Notification){
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    // send button shows after editing
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTextBox.text == "" {
            isTyping = false
            sendButton.isHidden = true
        } else {
            if isTyping == false {
                sendButton.isHidden = false
            }
            isTyping = true
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else {return}
            guard let message = messageTextBox.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                }
            }
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            
            return cell
    } else {
            return UITableViewCell()
        }
    }
}
