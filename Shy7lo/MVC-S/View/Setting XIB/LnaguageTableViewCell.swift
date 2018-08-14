//
//  LnaguageTableViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/13/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class LnaguageTableViewCell: UITableViewCell {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var buttonNext: UIButton!
    
    @IBOutlet var laLanguageName: UILabel!
    @IBOutlet var laLanguage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
