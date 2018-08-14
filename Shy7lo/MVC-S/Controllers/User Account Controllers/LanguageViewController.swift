//
//  LanguageViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/13/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    var lang:String?
    @IBOutlet var laLanguage: UILabel!
    
    @IBOutlet var buttonBack: UIButton!
    
    override func viewDidLoad() {
        
        lang = UserInfoDefault.getLanguage()
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        self.laLanguage.text = "LanguageLVC".localizableString(loc: lang!)
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buEnglish(_ sender: Any) {
        
        UserInfoDefault.saveLanguage(language: "en")
        self.changeViewControllers(isArabic: false)
        
      
    }
    
    @IBAction func buArabic(_ sender: Any) {
        UserInfoDefault.saveLanguage(language: "ar-SA")
        self.changeViewControllers(isArabic: true)
        
       
    }
    
    
    //change transition from Left to right or right to left
    func changeViewControllers(isArabic arabic : Bool){
        
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if arabic {
            
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().substituteFontName = "System"
            UITextField.appearance().substituteFontName = "System"
            
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().substituteFontName = "SF-Pro-Display"
            UITextField.appearance().substituteFontName = "SF-Pro-Display"
        }
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
        appDelegate?.window?.rootViewController = homeViewController
    }
    
}
