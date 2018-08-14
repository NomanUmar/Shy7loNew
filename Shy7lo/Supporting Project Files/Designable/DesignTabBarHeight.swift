//
//  DesignTabBarHeight.swift
//  Positivity
//
//  Created by Sajjad on 3/29/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class CustomTabBar : UITabBar {
    
    
    @IBInspectable var height: CGFloat = 0.0
    

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
     
            
            
            let bounds = UIScreen.main.bounds
            let screenheight = bounds.size.height
            if screenheight < 569{
            
            
            sizeThatFits.height = 40.0
            }else
            {
                sizeThatFits.height = 45.0
                
            }
            
        return sizeThatFits
        
    }
}
