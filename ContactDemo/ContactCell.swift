//
//  ContactCell.swift
//  ContactDemo
//
//  Created by Jayant Tiwari on 01/06/21.
//  Copyright © 2021 Expleo. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
