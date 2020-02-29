//
//  AppDelegate.swift
//  TwitterSample
//
//  Created by Comviva on 12/01/20.
//  Copyright © 2020 Comviva. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let targetVC = HomeModule.getHomeViewController()
        let navC = UINavigationController.init(rootViewController: targetVC)
        navC.navigationBar.isHidden = true
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        
        return true
    }


}

