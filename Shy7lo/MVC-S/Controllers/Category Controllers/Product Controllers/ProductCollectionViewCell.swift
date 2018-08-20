//
//  ProductCollectionViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/15/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var textCutView: UIView!
    @IBOutlet var addWishListImage: UIImageView!
    @IBOutlet var laDiscription: UILabel!
    @IBOutlet var laSpecialPrice: UILabel!
    @IBOutlet var laprice: UILabel!
    @IBOutlet var productImage: UIImageView!
    
   // for font size of label
    override func  layoutSubviews() {
        super.layoutSubviews()
        self.laDiscription.font = self.laDiscription.font.withSize(12)
        self.laSpecialPrice.font = self.laSpecialPrice.font.withSize(14)
        self.laprice.font = self.laprice.font.withSize(14)
        
    }
    
    
    
}
