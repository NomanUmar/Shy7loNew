//
//  SubCategoryTableViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/10/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {

    @IBOutlet var laSubCategoryName: UILabel!
    @IBOutlet var subCategoryImage: UIImageView!
    @IBOutlet var subCategoryView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
