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
    
    let socket = SocketManager(socketURL: URL(string: BASE_URL)!).defaultSocket
    
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
        socket.on("channelCreated"){ (dataArray, acknowledge) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[0] as? String else {return}
            guard let channelId = dataArray[0] as? String else {return}
            
            let newChannel = Channel( _id: channelId, name: channelName, description: channelDescription, __v: nil )
            MessageService.instance.channels.append(newChannel)
            
            completion(true)
        }
        
    }
}
