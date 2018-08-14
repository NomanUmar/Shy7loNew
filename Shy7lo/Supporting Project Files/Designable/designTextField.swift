//
//  designTextField.swift
//  idol
//
//  Created by Sajjad Yousaf on 5/8/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

@IBDesignable
class designTextField: UITextField {
    
    @IBInspectable var bottomBorderColor: UIColor? {
        get {
            return self.bottomBorderColor
        }
        set {
            self.borderStyle = UITextBorderStyle.none;
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = newValue?.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
            
            border.borderWidth = width
            self.layer.addSublayer(border)
            
            self.layer.masksToBounds = true
            
            let color = UIColor(red:0.75, green:0.75, blue:0.76, alpha:1.0)
            
            attributedPlaceholder = NSAttributedString(string:placeholder != nil ?placeholder! : "",attributes:[NSAttributedStringKey.foregroundColor: color])
            
        }
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 8, y: bounds.origin.y , width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 8, y: bounds.origin.y , width: bounds.width, height: bounds.height)
    }
    
    
    
}


/*
 @IBInspectable var leftImage: UIImage? {
 didSet {
 updateView()
 }
 }
 
 
 
 
 var iconWidth: CGFloat = 14
 var iconHight: CGFloat = 14
 
 
 @IBInspectable var leftPadding: CGFloat = 0
 
 @IBInspectable var radius: CGFloat = 0
 
 @IBInspectable var color: UIColor = UIColor.lightGray {
 didSet {
 updateView()
 }
 }
 
 @IBInspectable var bottomBorderColor: UIColor? {
 get {
 return self.bottomBorderColor
 }
 set {
 self.borderStyle = UITextBorderStyle.none;
 let border = CALayer()
 let width = CGFloat(1.5)
 border.borderColor = newValue?.cgColor
 border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
 
 border.borderWidth = width
 self.layer.addSublayer(border)
 
 self.layer.masksToBounds = true
 
 }
 }
 
 override func textRect(forBounds bounds: CGRect) -> CGRect {
 return CGRect(x: bounds.origin.x + iconWidth+10, y: bounds.origin.y+2 , width: bounds.width, height: bounds.height)
 }
 
 override func editingRect(forBounds bounds: CGRect) -> CGRect {
 return CGRect(x: bounds.origin.x + iconWidth+10, y: bounds.origin.y+2, width: bounds.width, height: bounds.height)
 }
 
 // Provides left padding for images
 override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
 var textRect = super.leftViewRect(forBounds: bounds)
 textRect.origin.x += leftPadding
 layer.cornerRadius = radius
 return textRect
 }
 
 
 
 func updateView() {
 if let image = leftImage {
 leftViewMode = UITextFieldViewMode.always
 let imageView = UIImageView(frame: CGRect(x: 2, y: 0, width: iconWidth, height: iconHight))
 imageView.image = image
 imageView.contentMode = .scaleAspectFill
 // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
 let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)) // has 5 point higher in width in imageView
 
 view.addSubview(imageView)
 
 
 leftView = view
 imageView.tintColor = color
 leftView = imageView
 } else {
 leftViewMode = UITextFieldViewMode.never
 leftView = nil
 }
 
 
 
 // Placeholder text color
 attributedPlaceholder = NSAttributedString(string:placeholder != nil ?placeholder! : "",attributes:[NSAttributedStringKey.foregroundColor: color])
 
 
 
 // for border bottom line white
 /*  let border = CALayer()
 let width = CGFloat(1.5)
 border.borderColor = UIColor.white.cgColor
 border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
 
 border.borderWidth = width
 self.layer.addSublayer(border)
 self.layer.masksToBounds = true */
 }
 */
