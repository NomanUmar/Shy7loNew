//
//  UserInfoDefault.swift
//  Positivity
//
//  Created by Sajjad Yousaf on 4/6/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

@objc class UserInfoDefault: NSObject {

    //---- save data in user Default----
    
    
    static func saveFirstInstallation(FirstInstallation: Bool) {
        UserDefaults.standard.set(FirstInstallation, forKey: "FirstInstallation")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    
    static func saveLanguage(language: String) {
        UserDefaults.standard.set(language, forKey: "language")
        UserDefaults.standard.synchronize()
    }
    
    static func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.synchronize()
    }
    
    static func saveDeviceToken(deviceToken: String) {
        UserDefaults.standard.set(deviceToken, forKey: "Device_Token")
        UserDefaults.standard.synchronize()
    }
    
    
    static func saveCountyCode(countyCode: String) {
        UserDefaults.standard.set(countyCode, forKey: "Country_Code")
        UserDefaults.standard.synchronize()
    }
    
    static func saveApiInitdata(appInit: AppInitResponse){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(appInit) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "AppInit")
            
        }
    }
    
    static func saveCategoryID(categoryID: String) {
        UserDefaults.standard.set(categoryID, forKey: "categoryID")
        UserDefaults.standard.synchronize()
    }
    
    static func saveCurrancyEnglish(currancyEnglish: String) {
        UserDefaults.standard.set(currancyEnglish, forKey: "currancyEnglish")
        UserDefaults.standard.synchronize()
    }
    
    static func saveCurrancyArabic(currancyArabic: String) {
        UserDefaults.standard.set(currancyArabic, forKey: "currancyArabic")
        UserDefaults.standard.synchronize()
    }
    
    static func saveCountryName(countryName: String) {
        UserDefaults.standard.set(countryName, forKey: "countryName")
        UserDefaults.standard.synchronize()
    }
    
   
    

    
    //------- get data in user Default ------
    
    static func getFirstInstallation() -> Bool {
        guard let userValue =  UserDefaults.standard.value(forKey: "FirstInstallation") as? Bool else {return false}
        return userValue
    }
    
    
    static func getLanguage() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "language") as? String else {return ""}
        return userValue
    }
    
    static func getToken() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "token") as? String else {return ""}
        return userValue
    }
    
    static func getDeviceToken() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "Device_Token") as? String else {return ""}
        return userValue
    }
    
    
    static func getCountryCode() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "Country_Code") as? String else {return ""}
        return userValue
    }
    
    static func getCategoryID() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "categoryID") as? String else {return ""}
        return userValue
    }
    
     static func getCurrancyEnglish() -> String {
    guard let userValue =  UserDefaults.standard.value(forKey: "currancyEnglish") as? String else {return ""}
    return userValue
}
    static func getCurrancyArabic() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "currancyArabic") as? String else {return ""}
        return userValue
    }
    
    
    static func getCountryName() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "countryName") as? String else {return ""}
        return userValue
    }
    
    
   
    //=============================================================================================
    
    
    // UserDefaults.standard.removeObject(forKey: "apiToken")
    
    
    static func removeAllUserDefault()
    {
        /*UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "user_email")
        UserDefaults.standard.removeObject(forKey: "confirmed")
        UserDefaults.standard.removeObject(forKey: "user_fullName")
        UserDefaults.standard.removeObject(forKey: "user_about")
        UserDefaults.standard.removeObject(forKey: "user_phoneNo")
        UserDefaults.standard.removeObject(forKey: "user_gender")
        UserDefaults.standard.removeObject(forKey: "user_dateOfBirth")
        UserDefaults.standard.removeObject(forKey: "user_stauts")
        UserDefaults.standard.removeObject(forKey: "user_adminAccess")
        UserDefaults.standard.removeObject(forKey: "user_level")
        UserDefaults.standard.removeObject(forKey: "user_currentHp")
        UserDefaults.standard.removeObject(forKey: "user_maxHp")
        UserDefaults.standard.removeObject(forKey: "user_currentExp")
        UserDefaults.standard.removeObject(forKey: "user_requiredExp")
        UserDefaults.standard.removeObject(forKey: "user_gold")
        UserDefaults.standard.removeObject(forKey: "user_gems")
        UserDefaults.standard.removeObject(forKey: "user_score")
        UserDefaults.standard.removeObject(forKey: "user_badgeCount")
        UserDefaults.standard.removeObject(forKey: "user_followersCount")
        UserDefaults.standard.removeObject(forKey: "user_choosedCategories")
        UserDefaults.standard.removeObject(forKey: "user_activeDp")
        UserDefaults.standard.removeObject(forKey: "user_profileImages")*/
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if key != "Device"{
                defaults.removeObject(forKey: key)
                print("delete \(key)")
            }
        }
        
    }
}
