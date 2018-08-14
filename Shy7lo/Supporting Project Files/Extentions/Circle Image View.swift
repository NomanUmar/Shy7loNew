//
//  File.swift
//  idol
//
//  Created by Sajjad Yousaf on 5/14/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func maskCircle() {
        
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.0).cgColor
        
    }
}
