//
//  SettingViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/13/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var lang:String!
    
    @IBOutlet var laSetting: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lang = UserInfoDefault.getLanguage()
        laSetting.text = "SettingSVC".localizableString(loc: lang)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.register(UINib(nibName: "LnaguageTableViewCell", bundle: nil), forCellReuseIdentifier: "LnaguageTableViewCell")
        
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
        
        tableView.register(UINib(nibName: "SizeTableViewCell", bundle: nil), forCellReuseIdentifier: "SizeTableViewCell")
        
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        
        tableView.register(UINib(nibName: "EmailTableViewCell", bundle: nil), forCellReuseIdentifier: "EmailTableViewCell")
        tableView.register(UINib(nibName: "PasswordTableViewCell", bundle: nil), forCellReuseIdentifier: "PasswordTableViewCell")
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //======================================================================================
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            if indexPath.row == 0
            {
                
               
                let cell = tableView.dequeueReusableCell(withIdentifier: "LnaguageTableViewCell", for:indexPath) as! LnaguageTableViewCell
              cell.laLanguage.text = "LanguageSVC".localizableString(loc: lang)
              cell.laLanguageName.text = "EnglishSVC".localizableString(loc: lang)
            let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
                cell.buttonNext.setImage(flippedImage, for: .normal)
                
                cell.mainView.tag = indexPath.row
                //for cell selection
                let tapCategoryView = UITapGestureRecognizer(target: self, action: #selector(tapCell(sender:)))
                cell.mainView.addGestureRecognizer(tapCategoryView)
                cell.mainView.isUserInteractionEnabled = true
              
                return cell
            }
            else if indexPath.row == 1
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for:indexPath) as! CurrencyTableViewCell
                
                cell.laCurrency.text = "CurrencySVC".localizableString(loc: lang)
                cell.laCurrancyName.text = "SaudiRiyalSVC".localizableString(loc: lang)
                let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
                cell.buttonNext.setImage(flippedImage, for: .normal)
                
                
              
                
                return cell
            }
            else if indexPath.row == 2
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SizeTableViewCell", for:indexPath) as!   SizeTableViewCell
                
                cell.laSize.text = "SizeSVC".localizableString(loc: lang)
                cell.laSizeName.text = "UKSVC".localizableString(loc: lang)
                let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
                cell.buttonNext.setImage(flippedImage, for: .normal)
                return cell
            }
            else if indexPath.row == 3
            {
                
                
            
 
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for:indexPath) as! NotificationTableViewCell
                cell.laNotification.text = "NotificationsSVC".localizableString(loc: lang)
                cell.laNotificationName.text = "SalesPromotionsSVC".localizableString(loc: lang)
        
            
                return cell
            }
        else if indexPath.row == 4
        {
            
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for:indexPath) as! EmailTableViewCell
            cell.laEmail.text = "EmailSVC".localizableString(loc: lang)
            cell.laChangeEmail.text = "ChangeEmailSVC".localizableString(loc: lang)
            
            
            return cell
        }
            else 
            {
             
                let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTableViewCell", for:indexPath) as! PasswordTableViewCell
                cell.laPassword.text = "PasswordSVC".localizableString(loc: lang)
                cell.laChangePasword.text = "ChangePasswordSVC".localizableString(loc: lang)
                
                
                return cell
        }
    }
    
    //==================================================================================
    //when tap on cell
    
    @objc func tapCell(sender: UITapGestureRecognizer) {
        //.. view all comment
        self.view.endEditing(true)
        
        let cellTag = sender.view
        
        
        let index  = (cellTag?.tag)!
        print(index as Any)
    
        
        
        if (index == 0){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
            
            //end ignoring intrection
            
            self.navigationController?.pushViewController(vc,animated: true)
        }
        
    }

}
