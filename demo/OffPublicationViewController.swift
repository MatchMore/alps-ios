//
//  OffPublicationViewController.swift
//  demo
//
//  Created by Wen on 19.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import os.log
import AlpsSDK
import Alps

class OffPublicationViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    //MARK: Properties
    
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var concertTextField: UITextField!
    @IBOutlet weak var concertLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rangeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var publishButton: UIBarButtonItem!
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var publication : Publication?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rangeTextField.delegate = self
        durationTextField.delegate = self
        publishButton.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // Cancels the add of a new publication
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Triggers when publishButton is pressed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === publishButton else {
            os_log("The save button was not pressed, cancelling, or no topic was chosen.", log: OSLog.default, type: .debug)
            return
        }
        
        let ourTopic = topicTextField.text!
        let ourRange : Double! = Double(rangeTextField.text!) ?? 100.0
        let ourDuration : Double! = Double(durationTextField.text!) ?? 60.0
        // Construct the properties
        var properties = [String: String]()
        properties[concertLabel.text!] = "'\(concertTextField.text!)'"
        properties[priceLabel.text!] = "'\(priceTextField.text!)'"
        
        print("topic : \(String(describing: ourTopic)), range : \(String(describing: ourRange!)), duration : \(String(describing: ourDuration!)), properties : \(String(describing: properties)).")
        createPublication(topic: ourTopic, range: ourRange, duration: ourDuration, properties: properties)
        
    }
    
    //MARK: AlpsSDK Functions
    
    // Calls The AlpsSDK to create a publication
    func createPublication(topic: String, range: Double, duration: Double, properties: Properties) {
        if self.appDelegate.device != nil {
            // XXX: the property syntax is tricky at the moment: in our example concert is a variable and 'montreuxjazz' is a string value
            
            self.appDelegate.alps.createPublication(topic: topic,
                                                    range: range, duration: duration,
                                                    properties: properties) {
                                                        (_ publication) in
                                                        if let p = publication {
                                                            print("Created publication: id = \(String(describing: p.publicationId)), topic = \(String(describing: p.topic)), properties = \(String(describing: p.properties))")
                                                            self.publication = p
                                                        }
            }
        }
    }
}
