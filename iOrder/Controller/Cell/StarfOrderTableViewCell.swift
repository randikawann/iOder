//
//  StarfOrderTableViewCell.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/30/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class StarfOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderTime: UILabel!
    
    @IBOutlet weak var starfId: UILabel!
    
    @IBOutlet weak var orderTatalCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
