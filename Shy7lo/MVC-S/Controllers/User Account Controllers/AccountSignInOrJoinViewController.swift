//
//  AccountSignInOrJoinViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/26/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class AccountSignInOrJoinViewController: UIViewController {

    @IBOutlet var laComeOnIn: UILabel!
    @IBOutlet var laAccount: UILabel!
    @IBOutlet var joinButton: UIButton!
    override func viewDidLoad() {
        // assign border color to button join
        joinButton.layer.borderWidth = 1.0
        joinButton.layer.borderColor =  UIColor.black.cgColor
        laAccount.text = "ACCOUNT"
        laAccount.addCharacterSpacing()
        
        laComeOnIn.text = "COME ON IN"
        laComeOnIn.addCharacterSpacing()
        
        
        
        //add spacing to the text of lable account or come on in
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buJoin(_ sender: Any) {
    }
    
    @IBAction func buNeedHelp(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: "Need help?", preferredStyle: .actionSheet)
        
        let HelpFAQs = UIAlertAction(title: "Help & FAQs", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Help & FAQs")
        })
        
        let Information = UIAlertAction(title: "Information", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Information")
        })
        
        let ForCustomers = UIAlertAction(title: "For customers", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("For customers")
        })
        
        let AppInfo = UIAlertAction(title: "App info", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("App info")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(HelpFAQs)
        optionMenu.addAction(Information)
        optionMenu.addAction(ForCustomers)
        optionMenu.addAction(AppInfo)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    @IBAction func buSignIn(_ sender: Any) {
    }
    

}
