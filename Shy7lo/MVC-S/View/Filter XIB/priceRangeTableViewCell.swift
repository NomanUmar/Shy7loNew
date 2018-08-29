//
//  priceRangeTableViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/28/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import RangeSeekSlider

class priceRangeTableViewCell: UITableViewCell,RangeSeekSliderDelegate{

    
    @IBOutlet var currencyMax: UILabel!
    @IBOutlet var currencyMin: UILabel!
    @IBOutlet var maxPrice: UILabel!
    @IBOutlet var minPrice: UILabel!
    @IBOutlet var priceRangeView: RangeSeekSlider!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
