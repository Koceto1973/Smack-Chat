//
//  ChannelCellTableViewCell.swift
//  Smack-Chat
//
//  Created by К.К. on 18.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var channelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell( channel:Channel) {
        let title = channel.name ?? ""
        channelName.text = "\(title)"
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel._id {
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }

}
