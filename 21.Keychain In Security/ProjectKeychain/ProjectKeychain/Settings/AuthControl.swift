//
// Created by 刘庆文 on 5-6.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit
import Foundation

class AuthControl
{
    private static let SERVICE_NAME = "KeychainService"
    
    static var isSignIn:Bool{
        guard let user = Settings.currentUser else {
            return false
        }
    
        do {
            let password = try KeychainPasswordItem(service: AuthControl.SERVICE_NAME, account: user.email).readPassword()
            return password.count > 0
        }catch {
            return false
        }
    }
    
    static func getEmailPassword() -> (String, String)?
    {
        guard let user = Settings.currentUser,
              let password = try? KeychainPasswordItem(service: AuthControl.SERVICE_NAME, account: user.email, accessGroup: nil).readPassword() else {
            return nil
        }
        
        return (user.email, password)
    }
    
    static func signIn(email:String, password:String) throws
    {
        if AuthControl.isSignIn {
            return
        }
    
        let id = UIDevice.current.name
        let user = User(id: id, email: email)
        Settings.currentUser = user
    
        try KeychainPasswordItem(service: AuthControl.SERVICE_NAME, account: email).savePassword(password)
    }
    
    static func signOut()
    {
        guard let user = Settings.currentUser else {
            return
        }
        
        try? KeychainPasswordItem(service: AuthControl.SERVICE_NAME, account: user.email).deleteItem()
        Settings.currentUser = nil
    }
}