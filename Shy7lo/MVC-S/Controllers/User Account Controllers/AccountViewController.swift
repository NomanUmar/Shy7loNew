//
//  AccountViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/13/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet var laAccount: UILabel!
    var lang:String!
    override func viewDidLoad() {
    
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lang = UserInfoDefault.getLanguage()
        laAccount.text = "AccountAVC".localizableString(loc: lang)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buSetting(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(vc,animated: true)
    }
    

}
