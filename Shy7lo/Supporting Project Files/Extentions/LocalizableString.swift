//
//  LocalizableString.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/6/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation


extension String{
    
    
    func localizableString(loc : String) -> String{
        
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        
    }
}
