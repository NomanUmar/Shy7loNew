//
//  TextFieldDesign.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/15/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable

class DesignableUITextField: UITextField {
    
    /*   // Provides left padding for images
     override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
     var textRect = super.leftViewRect(forBounds: bounds)
     textRect.origin.x += leftPadding
     return textRect
     }
     @IBInspectable var cornerRadius : CGFloat = 0{
     didSet{
     layer.cornerRadius = cornerRadius
     }
     }
     
     @IBInspectable var leftImage: UIImage? {
     didSet {
     updateView()
     }
     }
     
     @IBInspectable var leftPadding: CGFloat = 0
     
     @IBInspectable var color: UIColor = UIColor.lightGray {
     didSet {
     updateView()
     }
     }
     func updateView() {
     if let image = leftImage {
     leftViewMode = UITextFieldViewMode.always
     let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 21, height: 21))
     
     imageView.image = image
     imageView.tintColor = tintColor
     
     var width = leftPadding + 20
     
     
     if borderStyle == UITextBorderStyle.none || borderStyle ==  UITextBorderStyle.line
     {
     width = width + 5
     }
     let view = UIView(frame: CGRect(x: leftPadding, y: 0, width: width, height: 21))
     view.addSubview(imageView)
     // Note: In order for your image to use the tint color, you have to select
     // the image in the Assets.xcassets and change the "Render As" property to
     // "Template Image".
     
     leftView = view
     }
     else {
     leftViewMode = UITextFieldViewMode.never
     leftView = nil
     }
     
     
     // Placeholder text color
     attributedPlaceholder = NSAttributedString(string:placeholder != nil ?placeholder! : "",attributes:[NSAttributedStringKey.foregroundColor: color])
     
     } */
    @IBInspectable var RightImage: UIImage? {
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
        if let image = RightImage {
          rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 2, y: 0, width: iconWidth, height: iconHight))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)) // has 5 point higher in width in imageView
            
            view.addSubview(imageView)
            
            
            rightView = view
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
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
}
