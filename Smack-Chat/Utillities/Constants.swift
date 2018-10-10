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
let URL_REGISTER = URL_REGISTER_remote

let URL_LOGIN_remote = "\(BASE_URL_remote)/account/login"
let URL_LOGIN_local = "\(BASE_URL_local)/account/login"
let URL_LOGIN = URL_LOGIN_remote

// Headers
let HEADER = [ "Content-Type": "application/json; charset=utf-8" ]

// Segues
let TO_LOGIN = "ToLogin"
let TO_CREATE_ACCOUNT = "ToCreateAccount"
let UNWIND = "UnwindToChannel"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
