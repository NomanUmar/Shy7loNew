//
//  ViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/23/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//


import UIKit

class LaunchViewController: UIViewController {
    var window: UIWindow?
    @IBOutlet var preLoader: UIProgressView!
    let maxTime : Float = 3.0
    var currentTime : Float = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        let language = UserInfoDefault.getLanguage()
        if language.contains("ar"){
            TransitionArabic.switchViewControllers(isArabic: true)
            UILabel.appearance().substituteFontName = "System"
            UITextField.appearance().substituteFontName = "System"
        }else{
            TransitionArabic.switchViewControllers(isArabic: false)
        }
        
        self.callForAppInit()
        preLoader.setProgress(currentTime, animated: true)
        perform(#selector(updateLoader), with: nil, afterDelay: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //to update loader
    
    @objc func updateLoader(){
        
        currentTime = currentTime + 1.0
        preLoader.progress = currentTime/maxTime
        
        if currentTime < maxTime {
            
            perform(#selector(updateLoader), with: nil, afterDelay: 1.0)
        }else{
            self.nextController()
        }
    }
    
    
    func nextController(){
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newInstallation = UserDefaults.standard.bool(forKey: "newInstallation")
        //check app new install or not, first time insall or not
        if newInstallation  {
            print("Not first launch.")
            
            let language = UserInfoDefault.getLanguage()
            if language.contains("ar"){
                TransitionArabic.switchViewControllers(isArabic: true)
                UILabel.appearance().substituteFontName = "System"
                UITextField.appearance().substituteFontName = "System"
            }else{
                TransitionArabic.switchViewControllers(isArabic: false)
            }
            // self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "LandingViewController")
            
            let vc = storyboard.instantiateViewController(withIdentifier: "LandingViewController") as! LandingViewController
            
            
            self.navigationController?.pushViewController(vc,animated: true)
            
            
            
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "newInstallation")
            let locale = Locale.current
            
            let countrycode = locale.regionCode!
            
            UserInfoDefault.saveCountyCode(countyCode: countrycode)
            
            let preferredLanguage = NSLocale.preferredLanguages[0]
            
            print(preferredLanguage)
            
            if preferredLanguage.contains("ar"){
                UserInfoDefault.saveLanguage(language: "ar-SA")
                
                
                TransitionArabic.switchViewControllers(isArabic: true)
                //for arabic system font
                UILabel.appearance().substituteFontName = "System"
                UITextField.appearance().substituteFontName = "System"
                
                let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(vc,animated: true)
                
            }else{
                
                TransitionArabic.switchViewControllers(isArabic: false)
                UserInfoDefault.saveLanguage(language: "en")
                let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(vc,animated: true)
                
            }
        }
        //present((self.window?.rootViewController)!, animated:false, completion:nil)
    }
    
    func callForAppInit(){
        let deviceToken = UserInfoDefault.getDeviceToken()
        let country = UserInfoDefault.getCountryCode()
        
        
        let appInit = AppInit(device_token: deviceToken, device_type: "ios", app_version: "3.0.0", country: country)
        
        
        ApisCallingClass.appInitialization(user: appInit) { (data) in
            if(data != nil){
                
                let apiInitResponse : AppInitResponse = data!
                print(apiInitResponse)
                
                let token = apiInitResponse.api_token
                UserInfoDefault.saveToken(token: token)
                //save apiInitdata to default
                UserInfoDefault.saveApiInitdata(appInit: apiInitResponse)
                
                
                
            }else{
                self.showToast(message: "Error while loading data")
            }
        }
    }
}

