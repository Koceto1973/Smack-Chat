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
let BASE_URL = "https://some-smack-chat.herokuapp.com" + "/v1"   // app api domain from heroku, version 1
let URL_REGISTER = "\(BASE_URL)/account/register"

// Segues
let TO_LOGIN = "ToLogin"
let TO_CREATE_ACCOUNT = "ToCreateAccount"
let UNWIND = "UnwindToChannel"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
