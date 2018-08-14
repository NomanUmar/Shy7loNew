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
    
    static func saveConfirmed(confirmed: Bool) {
        UserDefaults.standard.set(confirmed, forKey: "confirmed")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    
    static func savePrivacyPolicy(privacy_policy: String) {
        UserDefaults.standard.set(privacy_policy, forKey: "privacy_policy")
        UserDefaults.standard.synchronize()
    }
    
    static func saveTermsCons(terms_cons: String) {
        UserDefaults.standard.set(terms_cons, forKey: "terms_cons")
        UserDefaults.standard.synchronize()
    }
    
    static func saveConfirmation(confirmation: Bool) {
        UserDefaults.standard.set(confirmation, forKey: "IAP")
        UserDefaults.standard.synchronize()
    }
    
    static func saveTwitter(twitter: String) {
        UserDefaults.standard.set(twitter, forKey: "twitter")
        UserDefaults.standard.synchronize()
    }
    static func saveFacebook(facebook: String) {
        UserDefaults.standard.set(facebook, forKey: "facebook")
        UserDefaults.standard.synchronize()
    }
    static func saveInstagram(instagram: String) {
        UserDefaults.standard.set(instagram, forKey: "instagram")
        UserDefaults.standard.synchronize()
    }
    
    static func saveStatus(stauts: Int) {
        UserDefaults.standard.set(stauts, forKey: "user_stauts")
        UserDefaults.standard.synchronize()
    }
    
    static func saveExpire(expire: Bool) {
        UserDefaults.standard.set(expire, forKey: "expire")
        UserDefaults.standard.synchronize()
    }
    
    static func saveRestore(restore: Bool) {
        UserDefaults.standard.set(restore, forKey: "restore")
        UserDefaults.standard.synchronize()
    }
    
    static func saveUserLevel(userLevel: Int) {
        UserDefaults.standard.set(userLevel, forKey: "user_level")
        UserDefaults.standard.synchronize()
    }
    static func saveCurrentHp(currentHp: Int) {
        UserDefaults.standard.set(currentHp, forKey: "user_currentHp")
        UserDefaults.standard.synchronize()
    }
    static func saveMaxHp(maxHp: Int) {
        UserDefaults.standard.set(maxHp, forKey: "user_maxHp")
        UserDefaults.standard.synchronize()
    }
    
    static func saveCurrentExp(currentExp: Int) {
        UserDefaults.standard.set(currentExp, forKey: "user_currentExp")
        UserDefaults.standard.synchronize()
    }
    static func saveRequiredExp(requiredExp: Int) {
        UserDefaults.standard.set(requiredExp, forKey: "user_requiredExp")
        UserDefaults.standard.synchronize()
    }
    static func saveGold(gold: Int) {
        UserDefaults.standard.set(gold, forKey: "user_gold")
        UserDefaults.standard.synchronize()
    }
    static func saveGems(gems: Int) {
        UserDefaults.standard.set(gems, forKey: "user_gems")
        UserDefaults.standard.synchronize()
    }
    static func saveScore(score: Int) {
        UserDefaults.standard.set(score, forKey: "user_score")
        UserDefaults.standard.synchronize()
    }
    static func saveBadgeCount(badgeCount: Int) {
        UserDefaults.standard.set(badgeCount, forKey: "user_badgeCount")
        UserDefaults.standard.synchronize()
    }
    static func saveFollowersCount(followersCount: Int) {
        UserDefaults.standard.set(followersCount, forKey: "user_followersCount")
        UserDefaults.standard.synchronize()
    }
    
    static func saveChoosedCategories(choosedCategories: [String]) {
        UserDefaults.standard.set(choosedCategories, forKey: "user_choosedCategories")
        UserDefaults.standard.synchronize()
    }
    
    static func saveActiveDp(activeDp: String) {
        UserDefaults.standard.set(activeDp, forKey: "user_activeDp")
        UserDefaults.standard.synchronize()
    }
    
    static func saveProfileImages(profileImages: [String]) {
        UserDefaults.standard.set(profileImages, forKey: "user_profileImages")
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
    
    static func getConfirmed() -> Bool {
        guard let userValue =  UserDefaults.standard.value(forKey: "confirmed") as? Bool else {return false}
        return userValue
    }
    
    
    
    
    static func getPrivacyPolicy() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "privacy_policy") as? String else {return ""}
        return userValue
    }
    
    static func getTermsCons() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "terms_cons") as? String else {return ""}
        return userValue
    }
    
    static func getTwitter() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "twitter") as? String else {return ""}
        return userValue
    }
    static func getFacebook() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "facebook") as? String else {return ""}
        return userValue
    }
    static func getInstagram() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "instagram") as? String else {return ""}
        return userValue
    }
    
    static func getConfirmation() -> Bool {
        guard let userValue =  UserDefaults.standard.value(forKey: "IAP") as? Bool else {return false}
        return userValue
    }
    
    static func getStatus() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_stauts") as? Int else {return 0}
        return userValue
    }
    
    static func getExpire() -> Bool {
        guard let userValue =  UserDefaults.standard.value(forKey: "expire") as? Bool else {return false}
        return userValue
    }
    
    static func getRestore() -> Bool {
        guard let userValue =  UserDefaults.standard.value(forKey: "restore") as? Bool else {return false}
        return userValue
    }
    static func getLevel() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_level") as? Int else {return 0}
        return userValue
    }
    
    static func getCurrentHp() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_currentHp") as? Int else {return 0}
        return userValue
    }
    
    static func getMaxHp() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_maxHp") as? Int else {return 0}
        return userValue
    }
    
    static func getCurrentExp() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_currentExp") as? Int else {return 0}
        return userValue
    }
    
    static func getRequiredExp() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_requiredExp") as? Int else {return 0}
        return userValue
    }
    
    static func getGold() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_gold") as? Int else {return 0}
        return userValue
    }
    
    static func getGems() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_gems") as? Int else {return 0}
        return userValue
    }
    
    static func getScore() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_score") as? Int else {return 0}
        return userValue
    }
    
    static func getBadgeCount() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_badgeCount") as? Int else {return 0}
        return userValue
    }
    
    static func getFollowersCount() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_followersCount") as? Int else {return 0}
        return userValue
    }
    
    static func getChoosedCategories() -> [String] {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_choosedCategories") as? [String] else {return []}
        return userValue
    }
    
    static func getActiveDp() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_activeDp") as? String else {return ""}
        return userValue
    }
    
    static func getProfileImages() -> [String] {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_profileImages") as? [String] else {return []}
        return userValue
    }
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
