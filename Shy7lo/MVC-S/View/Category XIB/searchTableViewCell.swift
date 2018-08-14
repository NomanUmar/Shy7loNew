//
//  searchTableViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/9/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var lacategoryName: UILabel!
    @IBOutlet var categoryView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
