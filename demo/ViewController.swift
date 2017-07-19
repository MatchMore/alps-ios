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
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var alps : AlpsManager!
    var username : String?
    var deviceName : String?
    
    // Location information
    var lat : Double!
    var longit : Double!
    var alt : Double!
    var horiztonalAcc : Double!
    var verticalAcc : Double!
    var locationBuffer = [CLLocation]()
    var incrementBuffer : Int = 0
    var location : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.checkedView.isHidden = true
        self.alps = appDelegate.alps
        for _ in 1...5 {
        self.alps.onLocationUpdate(){
            (_ location) in
            if self.incrementBuffer < 5 {
                self.locationBuffer.append(location)
                self.incrementBuffer += 1
            }else{
                self.locationBuffer[self.incrementBuffer % 5] = location
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

    @IBAction func LoginButton(_ sender: Any) {
        
        let userInput = _username.text
        
        if(userInput == ""){
            return
        }
        self.appDelegate.username = userInput!
        self.appDelegate.deviceName = "\(String(describing: self.appDelegate.username))'s device"
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
    }
    
    func getLastLocation(){
        if let location = locationBuffer.last{
            self.lat = (location.coordinate.latitude)
            self.longit = (location.coordinate.longitude)
            self.alt = (location.altitude)
            self.horiztonalAcc = (location.horizontalAccuracy)
            self.verticalAcc = (location.verticalAccuracy)
            print("Your location is updated as follow : \(String(describing: lat!)), \(String(describing: longit!)), \(String(describing: alt!)), \(String(describing: horiztonalAcc!)), \(String(describing: verticalAcc!)).")
            loginButton.isHidden = false
        }else{
            print("UNFOUND LocationManager.")
        }
    }
    
    func verifyAccuracy(){
        if locationBuffer.count == 5 {
            var averageAccuracy : Double = 0.0
            var sumAccuracy : Double = 0.0
            for l in locationBuffer{
                sumAccuracy += l.horizontalAccuracy
            }
            averageAccuracy = sumAccuracy/5
            if averageAccuracy <= 100 {
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
    
    //MARK: SDK SCALPS METHOD
    
    func createDevice(username : String, completion: @escaping () -> Void) {
        alps.createUser(self.appDelegate.username) {
            (_ user) in
            if let u = user {
                print("Created user: id = \(String(describing: u.userId!)), name = \(String(describing: u.name!))")
                
                guard let userId = u.userId else{
                    print("ERROR : No userId found")
                    return
                }
                self.appDelegate.userId = userId
                
                guard let username = u.name else{
                    print("ERROR : No name found")
                    return
                }
                self.appDelegate.username = username
                
                self.alps.createDevice(name: self.appDelegate.deviceName, platform: "iOS 10.2",
                                       deviceToken: "870470ea-7a8e-11e6-b49b-5358f3beb662",
                                       latitude: self.lat, longitude: self.longit, altitude: self.alt,
                                       horizontalAccuracy: self.horiztonalAcc, verticalAccuracy: self.verticalAcc) {
                                        (_ device) in
                                        if let d = device {
                                            print("Created device: id = \(String(describing: d.deviceId!)), name = \(String(describing: d.name!))")
                                            self.appDelegate.device = d
                                            
                                            guard let deviceId = d.deviceId else{
                                                print("ERROR : No deviceId found.")
                                                return
                                            }
                                            self.appDelegate.deviceId = deviceId
                                            completion()
                                        }
                }
            }
        }
    }
    
    func monitorMatches() {
        alps.startMonitoringMatches()
    }
    
    func monitorMatchesWithCompletion(completion: @escaping (_ match: Match) -> Void) {
        alps.onMatch(completion: completion)
        alps.startMonitoringMatches()
    }
    
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
