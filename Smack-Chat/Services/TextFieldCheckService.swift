//
//  TextFieldCheckService.swift
//  Smack-Chat
//
//  Created by К.К. on 19.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation

class TextFieldCheckService {
    
    static let instance = TextFieldCheckService()
    
    let flag = true
    
    func usernameCheck( username: String? ) -> (Bool, String) {        
        return (true,"")
    }
    
    func emailCheck( email: String? ) -> (Bool, String) {
        return (true,"")
    }
    
    func passwordCheck( password: String? ) -> (Bool, String) {
        return (true,"")
    }
}
