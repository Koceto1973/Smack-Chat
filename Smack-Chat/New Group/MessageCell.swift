//
//  MessageCell.swift
//  Smack-Chat
//
//  Created by К.К. on 23.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell( message: Message){
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        // 2018-10-24T17:50:34:456Z
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = String(isoDate[..<end])
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
        
    }

}
