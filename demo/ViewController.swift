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
    
    @IBOutlet weak var checkedView: UIView!
    @IBOutlet weak var checkedLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var checkedImage: UIImageView!
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var alps : AlpsManager!
    var username : String?
    var deviceName : String?
    
    // Location information
    var latitude : Double!
    var longitude : Double!
    var altitude : Double!
    var horizontalAccuracy : Double!
    var verticalAccuracy : Double!
    var incrementBuffer : Int = 0
    var location : CLLocation?
    
    // MARK : View functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        // Ask for location permission
        // You might need to add "Privacy - Location Always Usage Description" and "Privacy - Location When In Use Usage Description" in your Info.plist file.
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus{
        case .authorizedWhenInUse:
            print("Location is authorized")
            break
        case .authorizedAlways:
            print("Location is authorized")
            break
        case .denied :
            self.appDelegate.locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            self.appDelegate.locationManager.requestWhenInUseAuthorization()
            break
        case .restricted :
            self.appDelegate.locationManager.requestWhenInUseAuthorization()
            break
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        self.checkedView.isHidden = true
        self.alps = appDelegate.alps
        
        // Check that the device location's horizontal accuracy is under a threshold, before letting the user connects.
        for _ in 1...5 {
            self.alps.onLocationUpdate(){
                (_ location) in
                if self.incrementBuffer < 5 {
                    self.appDelegate.locationBuffer.append(location)
                    self.incrementBuffer += 1
                }else{
                    self.appDelegate.locationBuffer[self.incrementBuffer % 5] = location
                    self.incrementBuffer += 1
                }
                self.verifyAccuracy()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: LOGIN FUNCTION

    /*
     *  Do some verifications after the user pressed the login UIButton.
     */
    @IBAction func LoginButton(_ sender: Any) {
        
        let userInput = _username.text
        
        if(_username.text?.isEmpty ?? true){
            usernameErrorLabel.textColor = UIColor(red: 0.998138010501862, green: 0.392119288444519, blue: 0.320700377225876, alpha: 1.0)
            usernameErrorLabel.isHidden = false
        } else {
            self.appDelegate.username = userInput!
            self.appDelegate.deviceName = "\(String(describing: self.appDelegate.username))'s device"
            getLastLocation()
            let device = DoLogin(self.appDelegate.username)
            if device != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(vc, animated: true, completion: nil)
            } else {
                print("ERROR IN API CALL, check MatchMore service is working.")
            }
        }
    }
    
    // Calls the functions that will create the user and the device in Matchmore
    func DoLogin(_ username: String) -> MobileDevice? {
        var d : MobileDevice?
        createDevice(username: username) {
            (_ device) in
            d = device
        }
        return d
    }
    
    // Store the last location's data for latter use
    func getLastLocation(){
        if let location = self.appDelegate.locationBuffer.last{
            self.latitude = (location.coordinate.latitude)
            self.longitude = (location.coordinate.longitude)
            self.altitude = (location.altitude)
            self.horizontalAccuracy = (location.horizontalAccuracy)
            self.verticalAccuracy = (location.verticalAccuracy)
            print("Your location is updated as follow : \(String(describing: latitude!)), \(String(describing: longitude!)), \(String(describing: altitude!)), \(String(describing: horizontalAccuracy!)), \(String(describing: verticalAccuracy!)).")
            loginButton.isHidden = false
        }else{
            print("UNFOUND LocationManager.")
        }
    }
    
    // Verify that average horizontal accuracy of last 5 locations is under a threshold
    func verifyAccuracy(){
        if self.appDelegate.locationBuffer.count == 5 {
            var averageAccuracy : Double = 0.0
            var sumAccuracy : Double = 0.0
            for l in self.appDelegate.locationBuffer{
                sumAccuracy += l.horizontalAccuracy
            }
            averageAccuracy = sumAccuracy/5
            if averageAccuracy <= 1000 {
                loginButton.isEnabled = true
                accuracyLabel.text = String(describing : averageAccuracy)
                checkedLabel.text = "Location accuracy checked"
                checkedLabel.textColor = UIColor(red:0.263448894023895, green:0.684073209762573, blue:0.294317364692688, alpha:1.0)
                setView(view: checkedView, hidden: false)
            }else{
                accuracyLabel.text = String(describing : averageAccuracy)
                loginButton.isEnabled = false
                checkedLabel.text = "Checking your location accuracy, wait a moment please."
                checkedLabel.textColor = UIColor(red: 0.998138010501862, green: 0.392119288444519, blue: 0.320700377225876, alpha: 1.0)
                checkedLabel.isHidden = false
                setView(view: checkedView, hidden: true)
            }
        }else{
            accuracyLabel.text = "Calculating..."
            checkedLabel.isHidden = false
            loginButton.isEnabled = false
            checkedLabel.text = "Checking your location accuracy, wait a moment please."
            checkedLabel.textColor = UIColor(red: 0.998138010501862, green: 0.392119288444519, blue: 0.320700377225876, alpha: 1.0)
            setView(view: checkedView, hidden: true)
        }
    }
    
    //MARK: AlpsSDK functions
    
    // Calls Matchmore to create the user and device
    func createDevice(username : String, completion: @escaping (_ device: MobileDevice?) -> Void) {
        var deviceCompletion = completion
        alps.createUser(self.appDelegate.username) {
            (_ user) in
            if let u = user {
                print("Created user: id = \(String(describing: u.id!)), name = \(String(describing: u.name!))")
                
                guard let userId = u.id else{
                    print("ERROR : No userId found")
                    return
                }
                self.appDelegate.userId = userId
                
                guard let username = u.name else{
                    print("ERROR : No name found")
                    return
                }
                self.appDelegate.username = username
                
                /*
                 * platform value and deviceToken are hard coded, change it in order to get real values.
                 */
                guard let latitude = self.latitude, let longitude = self.longitude, let altitude = self.altitude, let horizontalAccuracy = self.horizontalAccuracy, let verticalAccuracy = self.verticalAccuracy else{
                    print("ERROR : No location provided.")
                    return
                }
                
                self.alps.createMobileDevice(name: self.appDelegate.deviceName, platform: "iOS 10.2",
                                       deviceToken: "870470ea-7a8e-11e6-b49b-5358f3beb662",
                                       latitude: latitude, longitude: longitude, altitude: altitude,
                                       horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy) {
                                        (_ device) in
                                        if let d = device {
                                            guard let deviceId = d.id else{
                                                print("ERROR : No deviceId found.")
                                                return
                                            }
                                            guard let name = d.name else{
                                                print("ERROR : No device name found.")
                                                return
                                            }
                                            
                                            print("Created device: id = \(String(describing: deviceId)), name = \(String(describing: name))")
                                            self.appDelegate.device = d
                                            self.appDelegate.deviceId = deviceId
                                            deviceCompletion(device as? MobileDevice)
                                        }
                                    }
            }
        }
    }
    
    /*
     *  This method will get the device location and store it in the appDelegate. This method is continually called, which means that var location in appDelegate is constantly the last position of the device.
     */
    func onLocationUpdate() {
        alps.onLocationUpdate() {
            (_ location) in
            self.location = location
        }
    }
    
    //MARK: UI Related
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { _ in
            view.isHidden = hidden
        }, completion: nil)
    }
}
