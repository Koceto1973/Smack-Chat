//
//  Constants.swift
//  Smack-Chat
//
//  Created by К.К. on 7.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation

typealias CompletionHandler  = (_ Success:Bool) -> ()
typealias CompletionHandler_ = (_ Success: Bool, _ responseMessage: String, _ responseCode: Int)->()

// URL Constants
let BASE_URL_remote = "https://some-smack-chat.herokuapp.com" + "/v1"   // app api domain from heroku, version 1
let BASE_URL_local = "http://localhost:3005" + "/v1"                    // app api domain from local, version 1
let BASE_URL = BASE_URL_remote

var URL_REGISTER:String = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_USER_ADD = "\(BASE_URL)/user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)/user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel/"
let URL_GET_MESSAGES = "\(BASE_URL)/message/byCannel"

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

// Notifications
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")

// Headers
let HEADER = [ "Content-Type": "application/json; charset=utf-8" ]
let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

// Segues
let TO_LOGIN = "ToLogin"
let TO_CREATE_ACCOUNT = "ToCreateAccount"
let UNWIND = "UnwindToChannel"
let TO_AVATAR_PICKER = "ToAvatarPicker"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
