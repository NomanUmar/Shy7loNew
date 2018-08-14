//
//  buttonRadius.swift
//  idol
//
//  Created by Sajjad Yousaf on 5/8/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit


@IBDesignable 

class buttonRadius: UIButton {
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
            
            
            
        }
        
        
    }
    func updateView(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
    
}
