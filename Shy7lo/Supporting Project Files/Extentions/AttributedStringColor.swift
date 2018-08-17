//
//  AttributedStringColor.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/16/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import UIKit
extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        
    }
    
}
