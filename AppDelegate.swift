//
//  AppDelegate.swift
//  chamberly task 1
//
//  Created by Seneen Khan on 25/06/24.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tutorialViewController = TutorialViewController()
        window?.rootViewController = tutorialViewController
        window?.makeKeyAndVisible()
        
        return true
    }

    // ... other AppDelegate methods ...
}
