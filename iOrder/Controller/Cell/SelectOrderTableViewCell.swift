//
//  SelectOrderTableViewCell.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/28/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SelectOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderMealName: UILabel!
    @IBOutlet weak var orderMealPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
