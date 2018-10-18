//
//  Channel.swift
//  Smack-Chat
//
//  Created by К.К. on 18.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation

//struct Channel {
//    public private(set) var channelTitle: String!
//    public private(set) var channelDescription: String!
//    public private(set) var id: String!
//
//
//}

// swift4 way for simple json parsing
struct Channel: Decodable {
    // all items in, ordered and named the API way
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
    
    
}
