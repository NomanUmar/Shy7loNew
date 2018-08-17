//
//  Product.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/14/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
struct ProductResponse: Codable {
    
    var success:Int?
    var message:String?
    var data : product_data_response?
    
}

struct product_data_response: Codable {
    
    var total_count:Int?
    var request_params: product_request_params
    var product_listing : [product_listing]?
    
}

struct product_request_params: Codable {
    
    
    var category_ids:String?
    var limit: String?
    var page : String?
    var storeId:String?
    var sort_by : String?
    var direction : String?
   // var filter : filter_obj?
    
}

struct filter_obj: Codable {

    var brand: String?
    
}


struct product_listing: Codable {
    
    var entity_id:Int?
    var sku: String?
    var name : String?
    var type_id : String?
    var brand : String?
    var price :  Int?
    var special_price : Int?
    var special_from_date : String?
    var special_to_date : String?
    var image : String?
    var brand_id : Int?
    
    
}
