//
//  AppDelegate.swift
//  ThoughtTracker
//
//  Created by John Bogil on 11/24/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
        return true
    }
}

