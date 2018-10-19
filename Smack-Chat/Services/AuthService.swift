//
//  AuthService.swift
//  Smack-Chat
//
//  Created by К.К. on 9.10.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.string(forKey: TOKEN_KEY)! as String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.string(forKey: USER_EMAIL)! as String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser( email:String, password:String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                // swiftyJSON way
                guard let data = response.data else { return }
                do {
                    // reporting on successful registration
                    guard let dataText = String(data: data, encoding: .utf8 ) else {return}
                    if dataText.first != "{" {
                        print( String(data: data, encoding: .utf8 )! )
                    } else {
                        let json = try JSON(data: data)
                        print(json["message"])
                    }
                    
                    completion(true)
                }
                catch { print("swiftyJSON threw error on registering user: \(error)")  }
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func registerUser_( email:String, password:String, completion: @escaping CompletionHandler_ ) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        var responseMessage: String = ""
        var responseCode: Int = 0
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                // swiftyJSON way
                guard let data = response.data else { return }
                do {
                    // reporting on successful registration
                    guard var dataText = String(data: data, encoding: .utf8 ) else {return}
                    
                    if dataText.first != "{" {
                        let json = try JSON(data: data)
                        dataText = json["message"].stringValue
                        responseCode = 1
                    }
                    
                    responseMessage = dataText
                    debugPrint(responseMessage)
                    completion(true, responseMessage, responseCode)
                } catch {
                    debugPrint("swiftyJSON threw error on registering user: \(error)")
                    completion(false,  "Server response is uncertain on registering user", -1)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false, "Server response is error on registering user", -1)
            }
        }
    }
    
    func loginUser( email:String, password:String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                // standard way
//                if let json = response.result.value as? Dictionary<String,Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                
                // swiftyJSON way
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                        
                    completion(true)
                    }
                catch { print("swiftyJSON threw error, \(error)")  }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser_( email:String, password:String, completion: @escaping CompletionHandler_) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        var responseMessage: String = ""
        var responseCode: Int = 0
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                // standard way
                //                if let json = response.result.value as? Dictionary<String,Any> {
                //                    if let email = json["user"] as? String {
                //                        self.userEmail = email
                //                    }
                //                    if let token = json["token"] as? String {
                //                        self.authToken = token
                //                    }
                //                }
                
                // swiftyJSON way
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    
                    responseMessage = "user login confirmed"
                    debugPrint("\n\(responseMessage)\n")
                    completion(true,responseMessage,responseCode)
                }
                catch {
                    responseCode = -1
                    responseMessage = "server response parsing error on login, try again"
                    debugPrint("\n\(responseMessage)\n")
                    debugPrint("swiftyJSON threw error, \(error)")
                    completion(true,responseMessage,responseCode)
                }
            } else {
                responseCode = -1
                responseMessage = "server response error on login, try again"
                debugPrint("\n\(responseMessage)\n")
                debugPrint(response.result.error as Any)
                completion(false,responseMessage,responseCode)
            }
        }
    }
    
    func createUser( name:String, email:String, avatarName:String, avatarColor:String, completion: @escaping CompletionHandler ) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "name"  : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // swiftyJSON way
                guard let data = response.data else { return }
                self.setUserInfo(data:data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser_( name:String, email:String, avatarName:String, avatarColor:String, completion: @escaping CompletionHandler_ ) {
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "name"  : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor": avatarColor
        ]
        
        var responseCode = 0
        var responseMessage = ""
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // swiftyJSON way
                guard let data = response.data else { return }
                self.setUserInfo(data:data)
                
                responseMessage = "user created"
                debugPrint("\n\(responseMessage)\n")
                completion(true,responseMessage,responseCode)
            } else {
                responseCode = -1
                responseMessage = "server error on user creation, try again"
                debugPrint("\n\(responseMessage)\n")
                debugPrint(response.result.error as Any)
                completion(true,responseMessage,responseCode)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // swiftyJSON way
                guard let data = response.data else { return }
                self.setUserInfo(data:data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(data:Data){
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let name = json["name"].stringValue
            let email = json["email"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            
            UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
        }
        catch { print("swiftyJSON threw error, \(error)")  }
    }
    
}
