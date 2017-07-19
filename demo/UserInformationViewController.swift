//
//  UserInformationViewController.swift
//  demo
//
//  Created by Wen on 19.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import CoreLocation

class UserInformationViewController: UIViewController {

    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var location : CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.appDelegate.alps.onLocationUpdate(){
            (_ location) in
            self.location = location
        }
        self.usernameLabel.text = appDelegate.username
        self.deviceNameLabel.text = appDelegate.deviceName
        self.userIdLabel.text = appDelegate.userId!
        self.deviceIdLabel.text = appDelegate.deviceId!
        if let l = self.location{
            self.latitudeLabel.text = String(l.coordinate.latitude)
            self.longitudeLabel.text = String(l.coordinate.longitude)
        }else{
            self.latitudeLabel.text = "Locating..."
            self.longitudeLabel.text = "Please reload this view."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
