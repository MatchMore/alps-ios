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
        guard let match = self.match else{
            print("ERROR in MatchViewController : match not found.")
            return
        }
        matchIdLabel.text = match.matchId
        timeStampLabel.text = String(describing: match.timestamp!)
        if let publication = match.publication{
            topicLabel.text = publication.topic
            publicationIdLabel.text = publication.publicationId
            publicationRangeLabel.text = String(describing: publication.range!)
            publicationPropertiesLabel.text = String(describing: publication.properties!)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
