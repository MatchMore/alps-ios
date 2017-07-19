//
//  PublicationViewController.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import os.log
import AlpsSDK
import Alps

class PublicationViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    //MARK: TO DO
    //MARK: Properties
    
    @IBOutlet weak var topic1: TopicRadio!
    @IBOutlet weak var topic2: TopicRadio!
    @IBOutlet weak var topic3: TopicRadio!
    @IBOutlet weak var topic4: TopicRadio!
    @IBOutlet weak var rangeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var publishButton: UIBarButtonItem!
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var topicButtons = [TopicRadio]()
    
    let topics = ["ticketstosale", "sharingcar", "cupoftea", "void"]
    var topicSelected : String = ""
    var topicCount : Bool = false
    var publication : Publication?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicButtons.append(topic1)
        topicButtons.append(topic2)
        topicButtons.append(topic3)
        topicButtons.append(topic4)
        rangeTextField.delegate = self
        durationTextField.delegate = self
        publishButton.isEnabled = false
        // Do any additional setup after loading the view.
        setupButtonsTopic()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupButtonsTopic(){
        var i : Int = 0
        for t in topicButtons{
            t.topic = topics[i]
            t.button.setTitle(topics[i], for: .normal)
            // Setup the button action
            t.button.addTarget(self, action: #selector(PublicationViewController.topicButtonTapped(button:)), for: .touchUpInside)
            i = i + 1
        }
    }
    
    func topicButtonTapped(button: UIButton) {
        switch (button.titleLabel)!.text!{
        case "ticketstosale":
            topicButtons[0].button.isSelected = true
            topicButtons[0].button.backgroundColor = UIColor(red:0.00, green:0.82, blue:1.00, alpha:1.0)
            for i in 1...3{
                topicButtons[i].button.isSelected = false
                topicButtons[i].button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            }
            publishButton.isEnabled = true
            break
        case "sharingcar":
            topicButtons[1].button.isSelected = true
            topicButtons[1].button.backgroundColor = UIColor(red:0.00, green:0.82, blue:1.00, alpha:1.0)
            for i in 2...3{
                topicButtons[i].button.isSelected = false
                topicButtons[i].button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            }
            topicButtons[0].button.isSelected = false
            topicButtons[0].button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            publishButton.isEnabled = true
            break
        case "cupoftea":
            topicButtons[2].button.isSelected = true
            topicButtons[2].button.backgroundColor = UIColor(red:0.00, green:0.82, blue:1.00, alpha:1.0)
            for i in 0...1{
                topicButtons[i].button.isSelected = false
                topicButtons[i].button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            }
            topicButtons[3].button.isSelected = false
            topicButtons[3].button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            publishButton.isEnabled = true
            break
        case "void":
            topicButtons[3].button.isSelected = true
            topicButtons[3].button.backgroundColor = UIColor(red:0.00, green:0.82, blue:1.00, alpha:1.0)
            for i in 0...2{
                topicButtons[i].button.isSelected = false
                topicButtons[i].button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            }
            publishButton.isEnabled = true
            break
        default:
            break
            
        }
    }
    
     // MARK: - Navigation
 
    // This method lets you configure a view controller before it's presented.
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        print("we prepare...")
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === publishButton else {
            os_log("The save button was not pressed, cancelling, or no topic was chosen.", log: OSLog.default, type: .debug)
            return
        }
        var chosenTopic : TopicRadio?
        for t in topicButtons{
            if t.button.isSelected == true {
                chosenTopic = t
            }
        }
        
        if chosenTopic != nil{
            let ourTopic = chosenTopic?.button.titleLabel?.text
            let ourRange : Double! = Double(rangeTextField.text!) ?? 100.0
            let ourDuration : Double! = Double(durationTextField.text!) ?? 60.0
            print("topic : \(String(describing: ourTopic)), range : \(String(describing: ourRange)), duration : \(String(describing: ourDuration)).")
            createPublication(topic: ourTopic!, range: ourRange, duration: ourDuration)
        }
        
    }
    
    func createPublication(topic: String, range: Double, duration: Double) {
        if self.appDelegate.device != nil {
            // XXX: the property syntax is tricky at the moment: mood is a variable and 'happy' is a string value
            let properties = ["mood": "'happy'"]
            
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
