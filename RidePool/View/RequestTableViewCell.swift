//
//  RequestTableViewCell.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 16/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var from:UILabel!
    @IBOutlet weak var to:UILabel!
    @IBOutlet weak var time:UILabel!
    @IBOutlet weak var requester:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
