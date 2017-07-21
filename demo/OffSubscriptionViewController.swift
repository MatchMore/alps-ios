//
//  OffSubscriptionViewController.swift
//  demo
//
//  Created by Wen on 19.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//
import UIKit
import os.log
import AlpsSDK
import Alps

class OffSubscriptionViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    //MARK: Properties
    
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var concertTextField: UITextField!
    @IBOutlet weak var concertLabel: UILabel!
    @IBOutlet weak var rangeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var publishButton: UIBarButtonItem!
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var subscription : Subscription?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rangeTextField.delegate = self
        durationTextField.delegate = self
        publishButton.isEnabled = true
        publishButton.title = "Subscribe"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // Cancels the add of a new subscription
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
        let selector = "\(concertLabel.text!) = '\(concertTextField.text!)'"
        print(selector)
        
        print("topic : \(String(describing: ourTopic)), range : \(String(describing: ourRange)), duration : \(String(describing: ourDuration)), properties : \(String(describing: selector)).")
        createSubscription(topic: ourTopic, range: ourRange, duration: ourDuration, selector: selector)
        
    }
    
    //MARK: AlpsSDK Functions
    
    // Calls The AlpsSDK to create a subscription
    func createSubscription(topic: String, range: Double, duration: Double, selector: String){
        if self.appDelegate.device != nil {
            
            self.appDelegate.alps.createSubscription(topic: topic,
                                                     selector: selector, range: range, duration: duration) {
                                                        (_ subscription) in
                                                        if let s = subscription {
                                                            print("Created subscription: id = \(String(describing: s.subscriptionId!)), topic = \(String(describing: s.topic!)), selector = \(String(describing: s.selector!))")
                                                            self.subscription = s
                                                        }
            }
        }
    }
}
