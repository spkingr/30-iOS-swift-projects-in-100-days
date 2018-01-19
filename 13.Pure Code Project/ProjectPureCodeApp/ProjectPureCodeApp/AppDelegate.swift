//
//  AppDelegate.swift
//  ProjectPureCodeApp
//
//  Created by 刘庆文 on 1-18.
//  Copyright © 2018 Liuqingwen. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [ UIApplicationLaunchOptionsKey: Any ]?) -> Bool
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: MyViewController())
        self.window?.makeKeyAndVisible()
        return true
    }
}
