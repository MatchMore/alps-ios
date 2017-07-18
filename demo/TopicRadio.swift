//
//  TopicRadio.swift
//  demo
//
//  Created by Wen on 13.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit

@IBDesignable class TopicRadio: UIStackView {
    
    var topic : String?
    // Create the button
    let button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    init(frame: CGRect, topic: String) {
        super.init(frame: frame)
        self.topic = topic
        setupButtons()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private func setupButtons() {
        
        
        button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        
        // Arranging the view
        button.setTitleColor(UIColor.white, for: .normal)
        
        
        // Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 78.5).isActive = true
        
        
        
        
        // Add the button to the stack
        addArrangedSubview(button)
    }
    
    
    func setTopicUnselected(){
        button.isSelected = false
    }

}
