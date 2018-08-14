//
//  DesignableView.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/9/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class MyCustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
