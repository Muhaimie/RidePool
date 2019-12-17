//
//  Request.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 15/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class RideTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fromValue:UILabel!
    @IBOutlet weak var toValue:UILabel!
    @IBOutlet weak var timeValue:UILabel!
    @IBOutlet weak var driver:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
