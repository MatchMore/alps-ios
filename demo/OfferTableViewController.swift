//
//  OfferTableViewController.swift
//  
//
//  Created by Wen on 13.07.17.
//
//

import UIKit
import ScalpsSDK
import Scalps

class OfferTableViewController: UITableViewController {

    var publications = [Publication]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return publications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "OfferTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OfferTableViewCell else{
            fatalError("The dequeued cell is not an instance of OfferTableViewCell.")
        }
        
        // Configure the cell...
        
        guard let pub = publications[indexPath.row] as? Publication else{
            fatalError("OfferTableViewController error : the publication is not from a Publication class.")
        }
        cell.publicationIdLabel.text = pub.publicationId!
        cell.latitudeLabel.text = String(describing: pub.location?.latitude)
        cell.longitudeLabel.text = String(describing: pub.location?.longitude)
        cell.topicLabel.text = pub.topic!
        cell.deviceIdLabel.text = pub.deviceId!
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Action
    @IBAction func unwindToPublicationList(sender: UIStoryboardSegue) {
        print("hello")
        if let sourceViewController = sender.source as? OfferViewController, let publication = sourceViewController.publication {
            
            // Add a new publication.
            let newIndexPath = IndexPath(row: publications.count, section: 0)
            
            publications.append(publication)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }

    }
    
    //MARK: Private Methods
    
    private func loadPublications() {
        
    }
    
}
