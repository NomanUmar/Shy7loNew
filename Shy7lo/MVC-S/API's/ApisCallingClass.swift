//
//  File.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/7/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApisCallingClass: NSObject {
    //Login Api call response as structure type POST Request
    
    class func appInitialization(user:AppInit , onCompletion :@escaping (AppInitResponse?)-> Void){
        let url = URLs.AppInit
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(user)
        ApiManager.post(Url: url, user: jsonData) { (data ,success:Bool) in
            
            if success {
                do {
                    
                    print(JSON(data))
                    let jsonDecoder = JSONDecoder()
                    let res = try jsonDecoder.decode(AppInitResponse.self, from: data  ) as  AppInitResponse
                    
    
                    onCompletion(res)
                    
                }    catch let error {
                    print(" Error --->  \(error)")
                }
            } else {
                
                let message = JSON(data)
                print(message)
                
                onCompletion(nil)
                
            }
        }
    }
    
    //get Sub Categories by IDs
    
    class func  getSubCategoriesID(id: String,onCompletion :@escaping (SubCategoriesResponse?)-> Void){
        let url = URLs.SubCateoryId + id
        
        ApiManager.get(Url: url) { (data,success:Bool) in
            if success {
                do {
                    print(JSON(data))
                    let jsonDecoder = JSONDecoder()
                    let res = try jsonDecoder.decode(SubCategoriesResponse.self, from: data) as SubCategoriesResponse
                    print(res)
                    
                    onCompletion(res)
                    
                }    catch let error {
                    print(" error --->  \(error)")
                }
            }
            else {
                let message = JSON(data)
                let msg = message["message"].stringValue
                print(msg)
            }
        }
    }
    
    
    
    
}
