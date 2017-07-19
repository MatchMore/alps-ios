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
    
    // This method lets you configure a view controller before it's presented.
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
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
    
    //MARK: SDK function
    func createSubscription(topic: String, range: Double, duration: Double, selector: String){
        if self.appDelegate.device != nil {
            
            self.appDelegate.alps.createSubscription(topic: topic,
                                                     selector: selector, range: range, duration: duration) {
                                                        (_ subscription) in
                                                        if let s = subscription {
                                                            print("Created subscription: id = \(String(describing: s.subscriptionId!)), topic = \(String(describing: s.topic!)), selector = \(String(describing: s.selector!))")
                                                            self.subscription = s
                                                            
                                                            //                                                            // Arranging the view
                                                            //                                                            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 65))
                                                            //
                                                            //                                                            label.textAlignment = .center
                                                            //                                                            label.textColor = UIColor.white
                                                            //                                                            if let tValues = s.topic{
                                                            //                                                                label.text = "\(tValues)"
                                                            //                                                            }
                                                            //
                                                            //                                                            let view1 = UIView()
                                                            //                                                            view1.backgroundColor = UIColor(red:0.22, green:0.66, blue:0.81, alpha:1.0)
                                                            //                                                            view1.heightAnchor.constraint(equalToConstant: 65).isActive = true
                                                            //                                                            view1.widthAnchor.constraint(equalToConstant: 100).isActive = true
                                                            //                                                            view1.addSubview(label)
                                                            //                                                            label.frame.origin = CGPoint(x: view1.frame.width / 2, y: view1.frame.height / 2)
                                                            //                                                            self.topicSubscribedStack.addArrangedSubview(view1)
                                                        }
            }
        }
    }
}
