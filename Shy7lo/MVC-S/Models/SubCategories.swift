//
//  Categories.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/9/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation

struct SubCategoriesResponse: Codable {
    
    var success:Int?
    var message:String?
    var data : data_response?

}

struct data_response: Codable {
    
    var request_params :request_params_response?
    var category:category_response?
    
}

struct request_params_response: Codable {
    
    var category_id : String?
    
}

struct category_response: Codable {
    
    var child_count : Int?
    var child_data :[child_data_response]?
    var id :String?
    var name : String?
    var banner : [banner_response]?
    
}
struct child_data_response: Codable {
    
    var name : String?
    var id :String?
    var count :Int64?
    var in_stock_items : Int64?
    var thumb : String?
    
}

struct banner_response: Codable {
    
    var image : String?
    var url :String?
   
    
}




