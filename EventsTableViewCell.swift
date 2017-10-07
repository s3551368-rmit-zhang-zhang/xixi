//
//  EventsTableViewCell.swift
//  Focus timer
//
//  Created by Zhang Zhang on 10/5/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var eventLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
