//
//  MatchesViewController.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import Alps
import AlpsSDK

class MatchViewController: UIViewController {
    
    //MARK: Properties
    
    var match : Match?
    var publication : Publication?
    var subscription : Subscription?
    
    @IBOutlet weak var matchIdLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var publicationIdLabel: UILabel!
    @IBOutlet weak var publicationRangeLabel: UILabel!
    @IBOutlet weak var publicationPropertiesLabel: UILabel!
    @IBOutlet weak var subscriptionIdLabel: UILabel!
    @IBOutlet weak var subscriptionRangeLabel: UILabel!
    @IBOutlet weak var subscriptionPropertiesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the view and shows selected match informations
        guard let match = self.match else{
            print("ERROR in MatchViewController : match not found.")
            return
        }
        matchIdLabel.text = match.matchId
        timeStampLabel.text = transformTimestampToDate(timestamp: match.timestamp!)
        if let publication = match.publication{
            topicLabel.text = publication.topic
            publicationIdLabel.text = publication.publicationId
            publicationRangeLabel.text = String(describing: publication.range!)
            if let concert = publication.properties?["Concert"]{
                publicationPropertiesLabel.text = concert
            }
        }
        if let subscription = match.subscription{
            subscriptionIdLabel.text = subscription.subscriptionId
            subscriptionRangeLabel.text = String(describing: subscription.range!)
            subscriptionPropertiesLabel.text = String(describing: subscription.selector!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper method
    
    // Use this function to transform timestampe to local date in String
    func transformTimestampToDate(timestamp : Int64) -> String {
        let dateTimeStamp = NSDate(timeIntervalSince1970:Double(timestamp)/1000)  //UTC time
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local //Edit
        dateFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
        
        return strDateSelect
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
