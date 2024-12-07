//
//  AppDelegate.swift
//  iOSTakeHomeTest
//
//  Created by Ahmed Azab on 07/12/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let characterListVC = CharacterListViewController()
        let navigationController = UINavigationController(rootViewController: characterListVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

