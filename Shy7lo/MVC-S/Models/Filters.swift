//
//  Filters.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 9/3/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
struct FilterResponse: Codable {
    
    var success:Int?
    var message:String?
    var data : filterDataObj?
    
}

struct filterDataObj: Codable {
    
    var layeredData:[layeredDataObj]?
    var sortingData:[sortingDataObj]?

    
}

struct layeredDataObj: Codable {
    
    var label:String?
    var code : String?
    var options:[optionsObj]?
    
}

struct sortingDataObj: Codable {
    var code :String?
    var label :String?
}

struct optionsObj: Codable {
    var label:String?
    var id:String?
    var count:String?
}
