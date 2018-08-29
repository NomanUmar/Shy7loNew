//
//  CategoryTableViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/21/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    
    @IBOutlet var selecteedImage: UIImageView!
    @IBOutlet var laFilterName: UILabel!
    @IBOutlet var tapView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
