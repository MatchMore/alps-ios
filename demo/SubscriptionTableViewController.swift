//
//  SubscriptionTableViewController.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import AlpsSDK
import Alps

class SubscriptionTableViewController: UITableViewController {
    
    var subscriptions = [Subscription]()
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if appDelegate.userId != nil && appDelegate.deviceId != nil {
            // call the API, to retrieve all the subscriptions for current user and device
            loadSubscriptions(userId: self.appDelegate.userId!, deviceId: self.appDelegate.deviceId!)
        }else{
            print("ERROR in SUBSCRIPTIONTABLEVIEWCONTROLLER: UserId or deviceId is nil.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subscriptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SubscriptionTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SubscriptionTableViewCell else{
            fatalError("The dequeued cell is not an instance of OfferTableViewCell.")
        }
        
        // Configure the cell...
        
        guard let sub = subscriptions[indexPath.row] as? Subscription else{
            fatalError("SubscriptionTableViewController error : the subscription is not from a Subscription class.")
        }
        cell.subscriptionIdLabel.text = sub.subscriptionId!
        cell.durationLabel.text = String(describing: sub.duration)
        cell.timeStampLabel.text = String(describing: sub.timestamp)
        cell.topicLabel.text = sub.topic!
        
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("our indexPath Row is : \(indexPath.row)")
         print("our subscription is : \(String(describing: subscriptions[indexPath.row].subscriptionId))")
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "Show Detail" {
             // Show the details of a match
             if let dVC = segue.destination as? DetailViewController{
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell){
                    dVC.subscription = subscriptionAtIndexPath(indexPath: indexPath as NSIndexPath)
                }
            }
        }
    }
    
     //MARK: HELPER method
     func subscriptionAtIndexPath(indexPath: NSIndexPath) -> Subscription{
     let subscription = subscriptions[indexPath.row]
     return subscription
     }
 
    //MARK: Action
    @IBAction func unwindToSubscriptionList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? SubscriptionViewController, let subscription = sourceViewController.subscription {
//            
//            // Add a new publication.
//            let newIndexPath = IndexPath(row: subscriptions.count, section: 0)
//            
//            subscriptions.append(subscription)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        }
//        
    }
    
    //MARK: Private Methods
    
    private func loadSubscriptions(userId: String, deviceId: String) {
        self.getAllSubscriptionsForDevice(userId, deviceId: deviceId)
    }
    
    //MARK: SDK func
    func getAllSubscriptionsForDevice(_ userId:String, deviceId: String) {
//        if self.appDelegate.deviceId != nil && self.appDelegate.userId != nil{
//            self.appDelegate.alps.getAllSubscriptionsForDevice(userId: String, deviceId: String) {
//                (_ subscriptions) in
//                if let s = subscriptions {
//                    self.subscriptions = s
//                }
//            }
//        }
    }

    
}
