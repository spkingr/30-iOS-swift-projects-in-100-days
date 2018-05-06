//
// Created by 刘庆文 on 5-3.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import Foundation

struct User:Codable
{
    let id:String
    let email:String
}

final class Settings
{
    private enum Keys:String
    {
        case user = "current_user"
    }
    
    static var currentUser:User?{
        get {
            guard let data = UserDefaults.standard.data(forKey: Settings.Keys.user.rawValue) else{
                return nil
            }
            let user = try? JSONDecoder().decode(User.self, from: data)
            return user
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: Settings.Keys.user.rawValue)
            } else {
                UserDefaults.standard.removeObject(forKey: Settings.Keys.user.rawValue) // REMOVE
            }
        }
    }
}