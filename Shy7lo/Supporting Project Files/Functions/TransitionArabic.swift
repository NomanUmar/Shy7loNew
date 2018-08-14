//
//  TransitionArabic.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/7/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class TransitionArabic: NSObject {
    
    
    class func switchViewControllers(isArabic arabic : Bool){
        
        if arabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }

}
