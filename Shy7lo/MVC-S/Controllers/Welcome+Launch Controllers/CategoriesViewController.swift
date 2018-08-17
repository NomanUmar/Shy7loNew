//
//  GenderViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 7/26/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    
    
    var categoryData: [BaseScreenObj]!
    var lang:String!
    var categoryId:String!
    @IBOutlet var buttonShopNow: UIButton!
    @IBOutlet var lachooseGender: UILabel!
    @IBOutlet var buttonSkip: UIButton!
    @IBOutlet var genderTitle: UILabel!
    @IBOutlet var genderSubTitle: UILabel!
    @IBOutlet var genderImage: UIImageView!
    @IBOutlet var genderControl: UIPageControl!
    @IBOutlet var genderSelect: UIPickerView!
    
    var categoryList = [String]()
    
    
    
    override func viewDidLoad() {
        
        
        // swipe right
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(repondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        self.view.addGestureRecognizer(swipeRight)
        
      print(categoryData)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.lang = UserInfoDefault.getLanguage()
        self.loadCategories()
        
        
        
        
        genderSubTitle.text = "SubTagLineGVC".localizableString(loc: lang)
        lachooseGender.text = "ShoppinForGVC".localizableString(loc: lang)
        let buShopNow = "BuShopNowGVC".localizableString(loc: lang)
        buttonShopNow.setTitle(buShopNow, for: .normal)
        let buSkip = "BuSkipGVC".localizableString(loc: lang)
        buttonSkip.setTitle(buSkip, for: .normal)
        genderTitle.text = "TagLineGVC".localizableString(loc: lang)
        
        
        genderSelect.dataSource = self
        genderSelect.delegate = self
        genderImage.image = UIImage(named: "Gender")
        genderControl.currentPage = 1
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    //Functions for picker view
    //================================================================
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return self.categoryList.count
            
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.categoryList[row]
       
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            self.genderImage.image = UIImage(named: "Gender")
            print(self.categoryList[row])
            self.categoryId = self.forCatagory(category: categoryList[row])
            print(categoryId!)
            UserInfoDefault.saveCategoryID(categoryID: categoryId)
        
    }
   //=====================================================================================
    
    @IBAction func buSkip(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "newInstallation")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LandingViewController") as!
        LandingViewController
        self.navigationController?.pushViewController(vc,animated: false)
    }
    
    @IBAction func buShopNow(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "newInstallation")
        let mytabbar = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        appDelegate.window?.rootViewController = mytabbar
    }
    //====================================================================
    
    func loadCategories(){
        
        for i in 0..<self.categoryData.count {
            
            if lang.contains("ar"){
                self.categoryList.append(self.categoryData[i].title_ar)
            }else{
                self.categoryList.append(self.categoryData[i].title_en)
            }
            
        }
        self.categoryId = self.categoryData[0].category_id
        UserInfoDefault.saveCategoryID(categoryID: categoryId)
        
    }
    
    func forCatagory(category:String) -> String{
        var code:String!
        for i in 0..<self.categoryData.count{
            
            if lang.contains("ar"){
                if category  == self.categoryData[i].title_ar{
                    
                    code = self.categoryData[i].category_id
                }
            }else{
                if category  == self.categoryData[i].title_en{
                    code = self.categoryData[i].category_id
                }
            }
        }
        print(code!)
        return code!
    }
    
    //==========================================================================
    // for swipe
    @objc func repondToGesture(gesture : UISwipeGestureRecognizer) {
        switch gesture.direction{
        case UISwipeGestureRecognizerDirection.right:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
            self.navigationController?.pushViewController(vc,animated: false)
        default:
            break
            
        }
    }
    
    
}
