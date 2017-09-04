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
    
    // MARK: Properties
    // An array that contains all the user's device subscriptions
    var subscriptions = [Subscription]()
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if appDelegate.userId != nil && appDelegate.deviceId != nil {
            // call the API, to retrieve all the subscriptions for current user and device
            getAllSubscriptionsForDevice(self.appDelegate.userId!, deviceId: self.appDelegate.deviceId!)
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
        let cellIdentifier = "SubscriptionTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SubscriptionTableViewCell else{
            fatalError("The dequeued cell is not an instance of OfferTableViewCell.")
        }
        
        // Configure the cell...
        guard let sub = subscriptions[indexPath.row] as? Subscription else{
            fatalError("SubscriptionTableViewController error : the subscription is not from a Subscription class.")
        }
        
        cell.subscriptionIdLabel.text = sub.id!
        cell.durationLabel.text = String(describing: sub.duration!)
        cell.timeStampLabel.text = transformTimestampToDate(timestamp: sub.createdAt!)
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
    
    // Get the subscription at index in subscriptions array
    func subscriptionAtIndexPath(indexPath: NSIndexPath) -> Subscription{
        let subscription = subscriptions[indexPath.row]
        return subscription
    }
    
    // Use this function to transform timestampe to local date displayed in String
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
 
    //MARK: Action
    
    @IBAction func unwindToSubscriptionList(sender: UIStoryboardSegue) {
    }
    
    //MARK: AlpsSDK Functions
    
    // Calls the SDK to get all subscriptions for specified userId and deviceId
    func getAllSubscriptionsForDevice(_ userId:String, deviceId: String) {
        self.appDelegate.alps.getAllSubscriptionsForDevice(userId, deviceId: deviceId) {
            (_ subscriptions) in
            self.subscriptions = subscriptions
            self.tableView.reloadData()
        }
    }

    
}
