//
//  designLabel.swift
//  idol
//
//  Created by Sajjad Yousaf on 5/11/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class designLabel: UILabel {

    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = 1
            // Whatever line spacing you want in points
            
            // peragraph allignment
            paragraphStyle.alignment = .center
            // *** Apply attribute to string ***
            // line spacing
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            self.attributedText = attributedString
        }
        
    }

}
