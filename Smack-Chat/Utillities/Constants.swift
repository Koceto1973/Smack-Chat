//
//  Constants.swift
//  Smack-Chat
//
//  Created by К.К. on 7.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success:Bool) -> ()

// URL Constants
let BASE_URL_remote = "https://some-smack-chat.herokuapp.com" + "/v1"   // app api domain from heroku, version 1
let BASE_URL_local = "http://localhost:3005" + "/v1"                    // app api domain from local, version 1

let URL_REGISTER_remote = "\(BASE_URL_remote)/account/register"
let URL_REGISTER_local = "\(BASE_URL_local)/account/register"
var URL_REGISTER:String = URL_REGISTER_remote

let URL_LOGIN_remote = "\(BASE_URL_remote)/account/login"
let URL_LOGIN_local = "\(BASE_URL_local)/account/login"
let URL_LOGIN = URL_LOGIN_remote

let URL_USER_ADD_remote = "\(BASE_URL_remote)/user/add"
let URL_USER_ADD_local = "\(BASE_URL_local)/user/add"
let URL_USER_ADD = URL_USER_ADD_remote

let URL_USER_BY_EMAIL_remote = "\(BASE_URL_remote)/user/byEmail/"
let URL_USER_BY_EMAIL_local = "\(BASE_URL_local)/user/byEmail/"
let URL_USER_BY_EMAIL = URL_USER_BY_EMAIL_remote

let URL_GET_CHANNELS_remote = "\(BASE_URL_remote)/channel/"
let URL_GET_CHANNELS_local = "\(BASE_URL_local)/channel/"
let URL_GET_CHANNELS = URL_GET_CHANNELS_remote

// Colors
let smackPurplePlaceHoder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

// Notifications
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

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
