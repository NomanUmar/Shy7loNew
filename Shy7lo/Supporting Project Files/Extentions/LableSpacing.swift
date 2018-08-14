//
//  File.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/27/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//


import Foundation
import UIKit

extension UILabel {
    func addCharacterSpacing() {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.15, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
