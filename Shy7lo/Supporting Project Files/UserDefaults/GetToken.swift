//
//  GetToken.swift
//  Positivity
//
//  Created by Sajjad Yousaf on 4/6/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class ApiToken: NSObject {
    /// when application restart then get api or check token
    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController
        if getApiToken() == nil {
            // go to auth screen
          //  vc = sb.instantiateInitialViewController()!
            vc = sb.instantiateViewController(withIdentifier: "SignInControllerNav")
        } else {
            // go to main screen
            vc = sb.instantiateViewController(withIdentifier: "TabBarVC")
        }
        
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.3,   options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
    // save api token when login or register
    class func saveApiToken(token:String)
    {
        // save token
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.synchronize()
        restartApp()
    }
    // get api token that we save after login or register
    
    class func getApiToken()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "token") as? String
    }
    
}

