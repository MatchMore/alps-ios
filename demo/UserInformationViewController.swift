//
//  UserInformationViewController.swift
//  demo
//
//  Created by Wen on 19.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class UserInformationViewController: UIViewController {

    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var deviceTokenLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var mapV: MKMapView!
    
    
    
    var location : CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapV.showsUserLocation = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        // Making rounded corner for view
//        lastLocationView.layer.cornerRadius = 5;
//        lastLocationView.layer.masksToBounds = true;
//        lastLocationView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
//        deviceIdView.layer.cornerRadius = 5;
//        deviceIdView.layer.masksToBounds = true;
//        deviceIdView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
//        userIdView.layer.cornerRadius = 5;
//        userIdView.layer.masksToBounds = true;
//        userIdView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        self.appDelegate.alps.onLocationUpdate(){
            (_ location) in
            self.location = location
        }
        self.usernameLabel.text = appDelegate.username
        self.deviceNameLabel.text = appDelegate.deviceName
        self.userIdLabel.text = appDelegate.userId!
        self.deviceIdLabel.text = appDelegate.deviceId!
        if let d = self.appDelegate.device {
            self.deviceTokenLabel.text = d.deviceToken!
            self.platformLabel.text = d.platform!
        } else {
            self.deviceTokenLabel.text = "Were not fulfill."
            self.platformLabel.text = "Were not fulfill."
        }
        
        if let l = self.location{
            self.latitudeLabel.text = String(l.coordinate.latitude)
            self.longitudeLabel.text = String(l.coordinate.longitude)
        }else{
            self.latitudeLabel.text = "Locating..."
            self.longitudeLabel.text = "Please reload this view."
        }
        
        if self.location != nil{
            // 1)
            mapV.mapType = MKMapType.standard
            
            // 2)
            
            // 3)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: (self.location?.coordinate)!, span: span)
            mapV.setRegion(region, animated: true)
            
            // 4)
            let annotation = MKPointAnnotation()
            annotation.coordinate = (self.location?.coordinate)!
            annotation.title = "Your current location"
            mapV.addAnnotation(annotation)
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
