//
//  MessageService.swift
//  Smack-Chat
//
//  Created by К.К. on 18.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannels(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data  = response.data else { return }
                do {
//                    if let json = try JSON(data: data).array {
//                        for item in json{
//                            let name = item["name"].stringValue
//                            let description = item["description"].stringValue
//                            let id = item["_id"].stringValue
//
//                            let channel = Channel(channelTitle: name, channelDescription: description, id: id )
//                            self.channels.append(channel)
//                        }
//                    }
                    
                    // // swift4 way for simple json parsing
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    //print(self.channels)
                    
                    completion(true)
                }
                catch { print("swiftyJSON trew error, \(error)")  }
                
            } else {
                completion( false )
                debugPrint(response.result.error as Any)
            }
        }
    }
}
