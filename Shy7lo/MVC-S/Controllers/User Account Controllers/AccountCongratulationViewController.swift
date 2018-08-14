//
//  AccountCongratulationViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/27/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class AccountCongratulationViewController: UIViewController {
    
    @IBOutlet var laAccount: UILabel!
    

    override func viewDidLoad() {
        
        laAccount.text = "ACCOUNT"
        laAccount.addCharacterSpacing()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
