//
//  AppDelegate.swift
//  demo
//
//  Created by Wen on 12.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import AlpsSDK
import Alps
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let APIKEY = "951f96ed-5e57-47a5-8e9a-ad9435c96498" // <- Please provide a valid Matchmore Application Api-key, obtain it for free on dev.matchmore.io
    
//    let ourLocationManager: CLLocationManager = CLLocationManager()
    var alps: AlpsManager!
    var userId : String?
    var deviceId : String?
    var username = ""
    var deviceName = ""
    var device : Device?
    var location : CLLocation?
    var locationManager = CLLocationManager()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if APIKEY.isEmpty {
            fatalError("To build the project, you NEED an APIKEY which is provided in the matchmore portal. Follow this link for more informations : dev.matchmore.com")
        }else{
            alps = AlpsManager(apiKey: APIKEY, clLocationManager : locationManager)
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // SDK Method
    func onLocationUpdate() {
        alps.onLocationUpdate() {
            (_ location) in
            self.location = location
        }
    }
    
}
