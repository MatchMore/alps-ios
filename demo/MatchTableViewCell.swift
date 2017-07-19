//
//  MatchesTableViewCell.swift
//  demo
//
//  Created by Wen on 14.07.17.
//  Copyright © 2017 jdu. All rights reserved.
//

import UIKit
import AlpsSDK
import Alps

class MatchTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var matchIdLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var match : Match?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
