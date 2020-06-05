//
//  AdminDishMenuTableViewCell.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 10/1/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class AdminDishMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var admindishimage: UIImageView!
    @IBOutlet weak var admindishname: UILabel!
   
    
    @IBOutlet weak var admindishcost: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
