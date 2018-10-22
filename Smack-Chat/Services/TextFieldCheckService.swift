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
        if username! == "" { return (false,"Please provide username!")}
        else {
            var forbidden:Bool = false
            
            for symbol in username! {
                switch symbol {
                case "a"..."z":
                    debugPrint()
                case "A"..."Z":
                    debugPrint()
                case "0"..."9":
                    debugPrint()
                case "_":
                    debugPrint()
                default:
                    forbidden = true
                }
            }
            
            if !forbidden {
                return(true,"username entry found correct")
            } else {
                return(false,"In username use only: 0..9 a..z A..Z _ ")
            }
            
        }
    }
    
    func emailCheck( email: String? ) -> (Bool, String) {
        if email! == "" { return (false,"Please provide email!")}
        else {
            var emailArray:[Character] = []
            var forbidden:Bool = false
            var at:Int = 0
            var dot:Int = 0
            
            for symbol in email! {
                emailArray.append(symbol)
                switch symbol {
                case "a"..."z":
                    debugPrint()
                case "A"..."Z":
                    debugPrint()
                case "0"..."9":
                    debugPrint()
                case "_":
                    debugPrint("")
                case "@":
                    at += 1
                case ".":
                    dot += 1
                default:
                    forbidden = true
                }
            }
            
            if forbidden { // used only 0...9 a...z A...Z @ .
                return(false,"In email use only 0...9 a...z A...Z @ .")
            } else if at != 1 {
                return(false,"In email only one @ is allowed.")
            } else if dot == 0 {
                return(false,"In email at least one dot is present.")
            } else if emailArray[0] == "@" || emailArray[emailArray.count-1] == "@" {
                return(false,"In email @ is not allowed first or last.")
            } else if emailArray[0] == "." || emailArray[emailArray.count-1] == "." {
                return(false,"In email . is not allowed first or last.")
            } else {
                var atIndex = -1
                var lastDotIndex = -1
                
                for index in 0...(emailArray.count-1) {
                    
                    if emailArray[index] == "@" {
                        atIndex = index
                        if emailArray[index-1] == "." || emailArray[index+1] == "." {
                            return(false,"In email . is not allowed next to @.")
                        }
                    }
                    
                    if emailArray[index] == "." {
                        lastDotIndex = index
                        if emailArray[index+1] == "." {
                            return(false,"In email a dot is not allowed next to another.")
                        }
                    }
                    
                    
                }
                if atIndex > lastDotIndex {
                    return(false,"In email there is a dot after @.")
                }
                return(true,"Email entry found correct")
            }
            
        }
    }
    
    func passwordCheck( password: String? ) -> (Bool, String) {
        if password! == "" { return (false,"Please provide password!")}
        else {
            var smallLetter:Bool = false
            var capitalLetter:Bool = false
            var number:Bool = false
            var forbidden:Bool = false
            
            for symbol in password! {
                switch symbol {
                case "a"..."z":
                    smallLetter = true
                case "A"..."Z":
                    capitalLetter = true
                case "0"..."9":
                    number = true
                default:
                    forbidden = true
                }
            }
            
            if capitalLetter && smallLetter && number && !forbidden {
                return(true,"password entry found correct")
            } else {
                return(false,"In password use 0..9 a..z A..Z ")
            }
            
        }
    }
}
