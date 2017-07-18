//
//  MatchesTableViewController.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import Scalps
import ScalpsSDK

class MatchTableViewController: UITableViewController {

    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var matches = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.monitorMatchesWithCompletion { (_ match) in self.addMatch(match: match)}
        // Do any additional setup after loading the view.

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        cell.matchIdLabel.text = m.matchId!
        cell.topicLabel.text = m.publication?.topic!
        cell.timeStampLabel.text = String(describing: m.timestamp)
        cell.selectorLabel.text = String(describing: m.description)
        
        
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
        print("our match is : \(String(describing: matches[indexPath.row].matchId))")
//        tableView.
//        
//         self.performSegue(withIdentifier: "matchSegue", sender: matches[indexPath.row])
        
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
    func matchAtIndexPath(indexPath: NSIndexPath) -> Match{
        let match = matches[indexPath.row]
        return match
    }
    
    
    //MARK: Update the table view
    func addMatch(match: Match){
        print("New match ! Added to matches.")
        matches.append(match)
        self.tableView.reloadData()
    }
    
    //MARK: Match methods
    
    func monitorMatches() {
        self.appDelegate.alps.startMonitoringMatches()
    }
    
    func monitorMatchesWithCompletion(completion: @escaping (_ match: Match) -> Void) {
        self.appDelegate.alps.onMatch(completion: completion)
        self.appDelegate.alps.startMonitoringMatches()
    }


}
