//
//  SceneDelegate.swift
//  chamberly task 1
//
//  Created by Seneen Khan on 25/06/24.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a new UIWindow using the windowScene constructor
        let window = UIWindow(windowScene: windowScene)
        
        // Create an instance of TutorialViewController
        let tutorialViewController = TutorialViewController()
        
        // Set the root view controller of the window with your TutorialViewController
        window.rootViewController = tutorialViewController
        
        // Make the window visible
        window.makeKeyAndVisible()
        
        // Set the window property of the scene delegate
        self.window = window
    }

    // ... other SceneDelegate methods ...
}
