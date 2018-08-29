//
//  Brands.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/28/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
struct BrandsResponse: Codable {
    
    var success:Int?
    var message:String?
    var data : [brands_response]?
    
}
struct brands_response: Codable {
    
    var label:String?
    var value:String?
    
}
