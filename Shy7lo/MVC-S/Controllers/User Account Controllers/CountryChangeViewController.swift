//
//  CountryChangeViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/17/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CountryChangeViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var selectCountry: UIPickerView!
    
    var lang:String!
    var countriesName = [String]()
    var countriesData : [CountriesObj]!
    var defaultCountry:String!
    var selectedCountry:String!
    var countryId:String!
    var appInitResponse:AppInitResponse?
    var countryCode : String!
    
    @IBOutlet var laSetting: UILabel!
    
    @IBOutlet var buttonBack: UIButton!

    override func viewDidLoad() {
        
        self.lang = UserInfoDefault.getLanguage()
        //set image in same direction with language
        self.countryCode =  UserInfoDefault.getCountryCode()
        print(self.countryCode)
       
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        self.laSetting.text = "countryChangeVC".localizableString(loc: lang!)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        selectCountry.delegate = self
        selectCountry.dataSource = self
        self.getCountriesAppInit()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //===========================================================================
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countriesName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countriesName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.countryImage.image = UIImage(named: countryListEn[row])
        print(self.countriesName[row])
        self.selectedCountry = self.countriesName[row]
        
        UserInfoDefault.saveCountryName(countryName: self.countriesName[row])
        self.countryId = self.forLoadImage(countryName: self.selectedCountry)
        UserInfoDefault.saveCountyCode(countyCode: self.countryId)
    }
    
    //===========================================================================
    
    func getCountriesAppInit(){
        //get data from userDefault
        //=========================================================================
        let data = UserDefaults.standard.value(forKey:"AppInit") as? Data
        let jsonDecoder = JSONDecoder()
        if let res = try? jsonDecoder.decode ( AppInitResponse.self , from: data!  ) as   AppInitResponse {
            
            self.appInitResponse = res
            self.countriesData = res.countries
            var country = [String]()
           
            //=========================================================================
            //get countries from response
            for i in 0..<self.countriesData.count {
                print("country------>\(self.countriesData[i])  \n \n \n \n")
                
                
                if lang.contains("ar"){
                    country.append(self.countriesData[i].full_name_locale)
                    
                }else{
                    country.append(self.countriesData[i].full_name_english)
                    
                }
                
            }
          
            
            //==============================================================================
            //array sort and save in countiesName
            self.countriesName = country.sorted()
            //===============================================================================
            //match from default country of mobile
            for j in 0..<self.countriesData.count{
                
                print(self.countryCode!)
                print(self.countriesData[j].id)
                
                if self.countryCode! == self.countriesData[j].id{
                    if lang.contains("ar"){
                        self.selectedCountry = self.countriesData[j].full_name_locale
                        self.defaultCountry = self.selectedCountry
                        
                        
                        //country in arabic because use at setting time
                        
                        UserInfoDefault.saveCountryName(countryName: self.selectedCountry)
                        
                        
                        //both language in arabic or english because use at setting time
                        let currancyArabic = self.countriesData[j].currency_ar
                        UserInfoDefault.saveCurrancyArabic(currancyArabic: currancyArabic)
                        let currancyEnglish = self.countriesData[j].currency_en
                        UserInfoDefault.saveCurrancyEnglish(currancyEnglish: currancyEnglish)
                        
                        
                    }else{
                        self.selectedCountry = self.countriesData[j].full_name_english
                        self.defaultCountry = self.selectedCountry
                        
                        
                        //country in english because use at setting time
                        
                        UserInfoDefault.saveCountryName(countryName: self.selectedCountry)
                        
                        
                        //both language in arabic or english because use at setting time
                        let currancyArabic = self.countriesData[j].currency_ar
                        UserInfoDefault.saveCurrancyArabic(currancyArabic: currancyArabic)
                        let currancyEnglish = self.countriesData[j].currency_en
                        UserInfoDefault.saveCurrancyEnglish(currancyEnglish: currancyEnglish)
                        
                    }
                }
                
            }
            //function call
            self.countryId = self.forLoadImage(countryName: self.selectedCountry)
            print(self.countryId)
            UserInfoDefault.saveCountyCode(countyCode: self.countryId)
            //==========================================================================
            //for default selection in picker
            for k in 0..<self.countriesName.count{
                if self.selectedCountry == self.countriesName[k]{
                    print(self.countriesName[k])
                    self.selectCountry.selectRow(k , inComponent:0, animated:true)
                    
                }
            }
            //===========================================================================
            
        }
        
        
    }
    
    //==========================================================================================
    func forLoadImage(countryName:String) -> String{
        var code:String!
        for i in 0..<self.countriesData.count{
            
            if lang.contains("ar"){
                if selectedCountry == self.countriesData[i].full_name_locale{
                //save currancy
                    UserInfoDefault.saveCurrancyArabic(currancyArabic: self.countriesData[i].currency_ar)
                    UserInfoDefault.saveCurrancyEnglish(currancyEnglish: self.countriesData[i].currency_en)
                    code = self.countriesData[i].id
                }
            }else{
                if selectedCountry == self.countriesData[i].full_name_english{
                    code =  self.countriesData[i].id
                    
                    //save currancy
                    UserInfoDefault.saveCurrancyArabic(currancyArabic: self.countriesData[i].currency_ar)
                    UserInfoDefault.saveCurrancyEnglish(currancyEnglish: self.countriesData[i].currency_en)
                    
                }
            }
        }
        
        print(code!)
        return code!
    }
    
    
    

}
