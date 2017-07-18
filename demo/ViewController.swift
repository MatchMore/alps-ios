//
//  ViewController.swift
//  demo-use-case
//
//  Created by Wen on 11.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import Alps
import AlpsSDK
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var _username: UITextField!
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var alps : AlpsManager!
    var username : String?
    var deviceName : String?
    
    // Location service
    // BE CAREFUL, THIS IS NOT THE LocationManager used in the ScalpsSDK
    var locationManager: CLLocationManager!
    var lat : Double!
    var longit : Double!
    var alt : Double!
    var horiztonalAcc : Double!
    var verticalAcc : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.alps = appDelegate.alps
        if locationManager == nil {
            print("locationManager is nil")
            // THE LOCATIONMANAGER takes some times to load. Maybe 1 or 2 seconds. Don't call directly getLastLocation()
            self.locationManager = self.appDelegate.ourLocationManager
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: LOGIN FUNCTION

    @IBAction func LoginButton(_ sender: Any) {
        
        let userInput = _username.text
        
        if(userInput == ""){
            return
        }
        self.appDelegate.username = userInput!
        self.appDelegate.deviceName = "\(String(describing: username))'s device"
        getLastLocation()
        DoLogin(self.appDelegate.username)
    }
    
    func DoLogin(_ username: String){
        createDevice(username: username) {
        }
        LoginIsDone()
    }
    
    func LoginIsDone(){
        _username.isEnabled = false
        // go to next view
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Navigation Controller")
//        self.present(nextViewController, animated:true, completion:nil)
    }
    //MARK: USEFUL LOGIN INFORMATION TO create the device
    
    func getLastLocation(){
        if locationManager != nil {
            self.lat = (self.locationManager.location?.coordinate.latitude)
            self.longit = (self.locationManager.location?.coordinate.longitude)
            self.alt = (self.locationManager.location?.altitude)
            self.horiztonalAcc = (self.locationManager.location?.horizontalAccuracy)
            self.verticalAcc = (self.locationManager.location?.verticalAccuracy)
            print("Your location is updated as follow : \(String(describing: lat)), \(String(describing: longit)), \(String(describing: alt)), \(String(describing: horiztonalAcc)), \(String(describing: verticalAcc)).")
            loginButton.isHidden = false
        }else{
            print("UNFOUND LocationManager.")
        }
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
//        
//        self.lat = newLocation.coordinate.latitude
//        self.longit = newLocation.coordinate.longitude
//        self.alt = newLocation.altitude
//        self.horiztonalAcc = newLocation.horizontalAccuracy
//        self.verticalAcc = newLocation.verticalAccuracy
//        print("Your location is updated as follow : \(String(describing: lat)), \(String(describing: longit)), \(String(describing: alt)), \(String(describing: horiztonalAcc)), \(String(describing: verticalAcc)).")
//        manager.stopUpdatingLocation()
//        loginButton.isHidden = false
//    }
    
    //MARK: SDK SCALPS METHOD
    
    func createDevice(username : String, completion: @escaping () -> Void) {
        alps.createUser(self.appDelegate.username) {
            (_ user) in
            if let u = user {
                print("Created user: id = \(String(describing: u.userId)), name = \(String(describing: u.name))")
                self.appDelegate.userId = u.userId!
                self.appDelegate.username = u.name!
                self.alps.createDevice(name: self.appDelegate.deviceName, platform: "iOS 10.2",
                                       deviceToken: "870470ea-7a8e-11e6-b49b-5358f3beb662",
                                       latitude: self.lat, longitude: self.longit, altitude: self.alt,
                                       horizontalAccuracy: self.horiztonalAcc, verticalAccuracy: self.verticalAcc) {
                                        (_ device) in
                                        if let d = device {
                                            print("Created device: id = \(String(describing: d.deviceId)), name = \(String(describing: d.name))")
                                            self.appDelegate.device = d
                                            completion()
                                        }
                }
            }
        }
    }
    
//    
//    func createSubscription() {
//        if device != nil {
//            let selector = "mood = 'happy'"
//            
//            self.alps.createSubscription(topic: "alps-ios-test",
//                                         selector: selector, range: 100.0, duration: 60) {
//                                            (_ subscription) in
//                                            if let s = subscription {
//                                                print("Created subscription: id = \(String(describing: s.subscriptionId)), topic = \(String(describing: s.topic)), selector = \(String(describing: s.selector))")
//                                            }
//            }
//        }
//    }
//    
//    func continouslyUpdatingLocation() {
//        if device != nil {
//            self.alps.startUpdatingLocation()
//        }
//    }
    
    func monitorMatches() {
        alps.startMonitoringMatches()
    }
    
    func monitorMatchesWithCompletion(completion: @escaping (_ match: Match) -> Void) {
        alps.onMatch(completion: completion)
        alps.startMonitoringMatches()
    }
}
