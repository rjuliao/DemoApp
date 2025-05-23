//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 20/03/25.
//

import UIKit
import Evergage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let evergage = Evergage.sharedInstance()
        
        //Set User ID as anonymous and attributes
        evergage.userId = evergage.anonymousId
        evergage.setUserAttribute("Raul", forName: "firstName")
        evergage.setUserAttribute("Juliao", forName: "lastName")
        evergage.setUserAttribute("raul@gmail.com", forName: "emailAddress")
        evergage.setUserAttribute("123456", forName: "zipCode")
        
        //Start the Evergage Configuration with our Dataset information
        evergage.start { (clientConfigurationBuilder)   in
            clientConfigurationBuilder.account = "sundoginteractive"
            clientConfigurationBuilder.dataset = "rj_prft_demo"
            // if we want to user push notification campaings
            clientConfigurationBuilder.usePushNotifications = true
            //Allow user-initiated gesture to connect to the Personalization web console for action mapping screens.
            clientConfigurationBuilder.useDesignMode = true
        }
        
        
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

