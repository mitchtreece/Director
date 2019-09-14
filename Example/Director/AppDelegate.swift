//
//  AppDelegate.swift
//  Director_Example
//
//  Created by Mitch Treece on 06/06/2019.
//  Copyright (c) 2019 Mitch Treece. All rights reserved.
//

import UIKit
import Director

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var director: SceneDirector?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13, *) {
            
            // We're on iOS 13 or greater. App related
            // UI initialization is handled in our SceneDelegate
            
        }
        else {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            self.director = SceneDirector(
                ExampleSceneCoordinator(),
                window: self.window!,
                debug: true
            ).start()
            
        }

        return true
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        // Called when the application is about to terminate.
        // Save data if appropriate. See also applicationDidEnterBackground:.
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(
            name: "Default",
            sessionRole: connectingSceneSession.role
        )
        
    }
    
    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running.
        // This will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
    }
    
}
