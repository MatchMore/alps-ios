//
//  DetailViewController.swift
//  demo
//
//  Created by Wen on 18.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import Alps
import AlpsSDK

class DetailViewController: UIViewController {

    //MARK: Properties
    
    var publication : Publication?
    var subscription : Subscription?
    
    @IBOutlet weak var labelIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var propertiesLabel: UILabel!
    @IBOutlet weak var labelPropertiesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = publication {
            labelIdLabel.text = "Publication ID :"
            labelPropertiesLabel.text = "Properties :"
            
            idLabel.text = p.publicationId
            deviceIdLabel.text = p.deviceId
            topicLabel.text = p.topic
            if let timestamp = p.timestamp{
                timeStampLabel.text = String(describing: timestamp)
            }
            if let range = p.range{
                rangeLabel.text = String(describing: range)
            }
            if let duration = p.duration {
                durationLabel.text = String(describing: duration)
            }
            if let location = p.location{
                if let latitude = location.latitude{
                    latitudeLabel.text = String(describing: latitude)}
                if let longitude = location.longitude{
                longitudeLabel.text = String(describing: longitude)}
            }
            if let properties = p.properties{
                propertiesLabel.text = String(describing: properties)
            }
        }
        
        if subscription != nil {
            labelIdLabel.text = "Subscription ID :"
            labelPropertiesLabel.text = "Selector :"
            
            idLabel.text = subscription?.subscriptionId
            deviceIdLabel.text = subscription?.deviceId
            topicLabel.text = subscription?.topic
            timeStampLabel.text = String(describing: subscription?.timestamp)
            rangeLabel.text = String(describing: subscription?.range)
            durationLabel.text = String(describing: subscription?.duration)
            latitudeLabel.text = String(describing: subscription?.location?.latitude)
            longitudeLabel.text = String(describing: subscription?.location?.longitude)
            propertiesLabel.text = String(describing: subscription?.selector)
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
