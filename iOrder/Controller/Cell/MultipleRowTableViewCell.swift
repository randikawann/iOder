//
//  MultipleRowTableViewCell.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/26/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class MultipleRowTableViewCell: UITableViewCell {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPrice: UILabel!
    @IBOutlet weak var mealimages: UIImageView!
    @IBOutlet weak var mealselect: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
