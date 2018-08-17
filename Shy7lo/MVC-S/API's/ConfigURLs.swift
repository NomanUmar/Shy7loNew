//
//  Config.swift
//  Positivity
//

//  Created by Sajjad Yousaf on 3/6/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//



import Foundation

struct  URLs {
    // base url of server
    static let baseUrl = "https://api2.shylabs.com"
    
    // POST App Initialization
    static let AppInit = baseUrl + "/api/init"

    // GET SubCategory by ID
    static let SubCateoryId = baseUrl + "/api/catalog/sub-category/"
    
    // get products
    //https://api2.shylabs.com/api/catalog/related/products/177
    static let getProductsId = baseUrl +  "/api/catalog/products?"
    
   //https://api2.shylabs.com/api/catalog/products?category_id=143&sort_by=created_at&direction=DESC&filter[brand]=289&page=1
    
    
    
    
}
