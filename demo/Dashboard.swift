//
//  Dashboard.swift
//  demo
//
//  Created by Wen on 12.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import Alps
import AlpsSDK

class Dashboard: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: Properties
    
    @IBOutlet weak var topicPicker: UIPickerView!
    
    @IBOutlet weak var topicSubscribedStack: UIStackView!
    var topicSelected : String = "ticketstosale"

    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let topics = ["ticketstosale", "sharingcar", "cupoftea", "void"]
    
    var subscription : Subscription?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topicPicker.delegate = self
        self.topicPicker.dataSource = self
        self.navigationItem.title = "\(self.appDelegate.username)'s dashboard"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        myLabel.text = topics[row]
        topicSelected = topics[row]
    }
    
    //MARK: Action
    
    @IBAction func subscribeButton(_ sender: UIButton) {
        createSubscription()
        
    }
    
    //MARK: SDK function
    func createSubscription(){
        if self.appDelegate.device != nil {
            let selector = "mood = 'happy'"
            
            self.appDelegate.alps.createSubscription(topic: topicSelected,
                                         selector: selector, range: 100.0, duration: 60) {
                                            (_ subscription) in
                                            if let s = subscription {
                                                print("Created subscription: id = \(String(describing: s.subscriptionId)), topic = \(String(describing: s.topic)), selector = \(String(describing: s.selector))")
                                                self.subscription = s
                                                
                                                // Arranging the view
                                                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 65))
                                                
                                                label.textAlignment = .center
                                                label.textColor = UIColor.white
                                                if let tValues = s.topic{
                                                    label.text = "\(tValues)"
                                                }
                                                
                                                let view1 = UIView()
                                                view1.backgroundColor = UIColor(red:0.22, green:0.66, blue:0.81, alpha:1.0)
                                                view1.heightAnchor.constraint(equalToConstant: 65).isActive = true
                                                view1.widthAnchor.constraint(equalToConstant: 100).isActive = true
                                                view1.addSubview(label)
                                                label.frame.origin = CGPoint(x: view1.frame.width / 2, y: view1.frame.height / 2)
                                                self.topicSubscribedStack.addArrangedSubview(view1)
                                            }
            }
        }
    }
    
}
