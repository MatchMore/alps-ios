//
//  OfferTableViewCell.swift
//  demo
//
//  Created by Wen on 13.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var publicationIdLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
