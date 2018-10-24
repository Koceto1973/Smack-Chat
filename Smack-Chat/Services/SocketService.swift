//
//  SocketService.swift
//  Smack-Chat
//
//  Created by К.К. on 18.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    lazy var socket:SocketIOClient = manager.defaultSocket
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    // request to the api for new channel
    func addChannel( channelName: String, channelDescription: String, completion: @escaping CompletionHandler ) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    // api confirmation for channel creation
    func getChannel( completion: @escaping CompletionHandler){
        socket.on("channelCreated"){ (dataArray, acknowledgement) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel( _id: channelId, name: channelName, description: channelDescription, __v: nil )
            
            MessageService.instance.channels.append(newChannel)
            
            completion(true)
        }
        
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") {  (dataArray, acknowledgement) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                
                MessageService.instance.messages.append(newMessage)
                completion(true)
                debugPrint("Message delivered.")
            } else {
                completion(false)
                debugPrint("Message not delivered.")
            }
        }
    }
}

