//
//  MianCategoryCollectionViewCell.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/9/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class MianCategoryCollectionViewCell: UICollectionViewCell {
    
//color for selected and un selected color
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.laCategoryName.textColor = .black
                self.underLineView.backgroundColor = .black
            }
            else
            {
                let color = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.0)
                self.laCategoryName.textColor = color
                self.underLineView.backgroundColor = color
            }
        }
    }
    
    @IBOutlet var laCategoryName: UILabel!
    
    @IBOutlet var underLineView: UIView!
}
