//
//  File.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 9/3/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
struct categoryResponse: Codable {
    
    var success:Int?
    var message:String?
    var data : categoryDataObj?
    
}


struct categoryDataObj: Codable {
    
    var id:Int?
    var parent_id:Int?
    var name : String?
    var is_active:Bool?
    var position : Int?
    var level : Int?
    var product_count : Int?
    var children_data : [children_data_Obj]?
    
    
}

struct children_data_Obj : Codable {
    
    var id:Int?
    var parent_id:Int?
    var name : String?
    var is_active:Bool?
    var position : Int?
    var level : Int?
    var product_count : Int?
    var children_data : [children_data_Obj]?
    
    
}

