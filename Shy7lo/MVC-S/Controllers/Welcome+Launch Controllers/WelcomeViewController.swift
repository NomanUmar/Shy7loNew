//
//  WelcomeViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/26/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

   
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var lahaveAccount: UILabel!
    @IBOutlet var laTagLine: UILabel!
    @IBOutlet var laWelcom: UILabel!
    override func viewDidLoad() {
        
        
        
        //buttonLogin.addBorder(side: .Bottom, color: .black, width: 1.0)
        
        let lang = UserInfoDefault.getLanguage()
        let login :String = "BuLoginWVC".localizableString(loc: lang)
        
        //SF Pro Display Semibold
        
        let attrs1 = [NSAttributedStringKey.foregroundColor : UIColor.black,NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue] as [NSAttributedStringKey : Any]
        let myString = NSMutableAttributedString(string: login, attributes: attrs1 as Any  as? [NSAttributedStringKey : Any] )
        
        
        
       
        buttonLogin.setAttributedTitle(myString, for: .normal)
        lahaveAccount.text = "HaveAccountWVC".localizableString(loc: lang)
        laTagLine.text = "YourPremierWVC".localizableString(loc: lang)
        laWelcom.text = "WelcomeWVC".localizableString(loc: lang)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buEnglish(_ sender: Any) {
        
        UserInfoDefault.saveLanguage(language: "en")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        self.navigationController?.pushViewController(vc,animated: false)
    }
    
    @IBAction func buArabic(_ sender: Any) {
        UserInfoDefault.saveLanguage(language: "ar-SA")
         TransitionArabic.switchViewControllers(isArabic: true)
         UILabel.appearance().substituteFontName = "System"
         UITextField.appearance().substituteFontName = "System"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        self.navigationController?.pushViewController(vc,animated: false)
    }
}
