//
//  AppDelegate.swift
//  WindowAbove
//
//  Created by Alexey Romanko on 23.01.2020.
//  Copyright © 2020 Romanko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        //let ad: ADViewModel = ADViewModel(param1: "app foreground < iOS 13", param2: "bottom", param3: "r1", param4: "r2", param5: "r3", callbackOpen: {
        let ad: ADViewModel = ADViewModel(params: "app foreground < iOS 13", "bottom", "p3", "p4", "p5",callbackOpen: {
        }) {  (val1, val2, val3) in
        }
        //ADPresenter.shared.initADEachTime = false // if false - don't reload page each time
        ADPresenter.shared.showAD(viewModel: ad)
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

