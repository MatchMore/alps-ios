//
//  MatchesTableViewController.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import AlpsSDK
import Alps

class MatchTableViewController: UITableViewController {

    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // An array that contains all the user's device match
    var matches = [Match]()
    var notificationCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This function will be called everytime there is a match.
        self.monitorMatchesWithCompletion { (_ match) in self.notificationOnMatch(match: match)}

        // Do any additional setup after loading the view.

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if appDelegate.userId != nil && appDelegate.deviceId != nil {
            // call the API, to retrieve all the subscriptions for current user and device
            getAllMatches()
            self.resetNotificationOnMatch()
        }else{
            print("ERROR in MATCHESVIEWCONTROLLER: UserId or deviceId is nil.")
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
        return matches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MatchTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MatchTableViewCell else{
            fatalError("The dequeued cell is not an instance of MatchTableViewCell.")
        }
        
        // Configure the cell...
        
        guard let m = matches[indexPath.row] as? Match else{
            fatalError("MatchTableViewController error : the publication is not from a Match class.")
        }
        
        cell.match = m
        
        cell.matchIdLabel.text = m.id!
        cell.topicLabel.text = m.publication?.topic!
        cell.timeStampLabel.text = transformTimestampToDate(timestamp: m.createdAt!)
        
        
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
            if let mVC = segue.destination as? MatchViewController{
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell){
                    mVC.match = matchAtIndexPath(indexPath: indexPath as NSIndexPath)
                }
            }
            
        }
    }
    
    //MARK: HELPER method
    
    // Get the match at index in matches array
    func matchAtIndexPath(indexPath: NSIndexPath) -> Match{
        let match = matches[indexPath.row]
        return match
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
    
    
    //MARK: Notification related
    
    // Shows notifications on match
    func notificationOnMatch(match: Match){
        notificationCounter += 1
        tabBarController?.tabBar.items?[0].badgeValue = String(describing: notificationCounter)
        let topic = match.publication?.topic
        let selector = match.subscription?.selector
        let alert = UIAlertController(title: "An interesting offer is close to you!", message: "Topic : \(String(describing: topic!))\nSelector : \(String(describing: selector!))", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Understood", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Resets the TabBar Item badge value
    func resetNotificationOnMatch(){
        notificationCounter = 0
        tabBarController?.tabBar.items?[0].badgeValue = nil
    }
    
    //MARK: AlpsSDK functions
    
    // Start the match service
    func monitorMatches() {
        self.appDelegate.alps.startMonitoringMatches()
    }
    
    // Get the match
    func monitorMatchesWithCompletion(completion: @escaping (_ match: Match) -> Void) {
        self.appDelegate.alps.onMatch(completion: completion)
        self.appDelegate.alps.startMonitoringMatches()
    }

    // Calls the SDK to get all matches for actual userId and deviceId
    func getAllMatches(){
        self.appDelegate.alps.getAllMatches() {
            (_ matches) in
            self.matches = matches
            self.tableView.reloadData()
        }
    }

}
