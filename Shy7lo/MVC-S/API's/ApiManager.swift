//
//  ApiManager.swift
//  Positivity
//
//  Created by Sajjad Yousaf on 4/6/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    class func get(Url:String , onCompletion :@escaping (Data, _ success:Bool)-> Void){
        
        let url = URL(string:Url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = UserInfoDefault.getToken()
        let lang = UserInfoDefault.getLanguage()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Api-Token")
        if lang.contains("ar"){
            
            request.addValue("ar", forHTTPHeaderField: "Lang")
        }else{
            request.addValue("en", forHTTPHeaderField: "Lang")
        }
        
        Alamofire.request(request)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure:
                    let data : Data = response.data!
                    print(JSON(data))
                    onCompletion(data , false)
                    
                case .success:
                    
                    let data:Data = response.data!
                    onCompletion(data , true)
                }
        }
    }
    
  
    
    
    class func post(Url:String, user:Data , onCompletion :@escaping (Data, _ success:Bool)-> Void)
    {
        
        
        print("PRINT IN POST--->\(JSON(user))")
        let url = URL(string:Url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let token = UserInfoDefault.getToken()
        let lang = UserInfoDefault.getLanguage()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Api-Token")
        if lang.contains("ar"){
            
            request.addValue("ar", forHTTPHeaderField: "Lang")
        }else{
             request.addValue("en", forHTTPHeaderField: "Lang")
        }
        
        request.httpBody = user
        
        
        
    Alamofire.request(request)
         .validate(statusCode: 200..<300)
         .responseJSON { response in
         
         switch response.result {
         
         case .failure(let error):
         
         let data : Data = response.data!
         print("print DaTA-->\(JSON(data))")
         print("ERROR--->\(error)")
         onCompletion(data , false)
         
         case .success:
         
         let data:Data = response.data!
         onCompletion(data , true)
         }
         }
    }
    
    
}


