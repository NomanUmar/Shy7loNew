//
//  Config.swift
//  Positivity
//

//  Created by Sajjad Yousaf on 3/6/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//



import Foundation

struct  URLs {
    // base url of server
    static let baseUrl = "https://api2.shylabs.com"
    
    // POST App Initialization
    static let AppInit = baseUrl + "/api/init"
//
    // GET SubCategory by ID
    static let SubCateoryId = baseUrl + "/api/catalog/sub-category/"

    //GET Categories
    
    static let CategoriesUrl = baseUrl + "/fetch_Data/fetch_category"
    
    // reset Password
    
    static let ChangePassword = baseUrl +  "/user/change/password"
    
    //get  add favrt
    ///user/add_favourite/5b14b205846d53668c4ac3f4
    static let AddFavourite = baseUrl + "/user/add_favourite/"
    
    //get  add favrt
     ///user/remove_favourite/5b14b205846d53668c4ac3f4
    static let RemoveFavourite = baseUrl + "/user/remove_favourite/"
   
    
    //Get for Favourite all fvrt images
    
   static let FavouriteImages = baseUrl +  "/user/list_favourite"
    
    //Get feed by id
    static let AddManifestation = baseUrl + "/user/add_manifestation"
    
    // fetch all manifestation 
    
    static let FetchManifestation = baseUrl + "/user/list_manifestation"


    // remove manifestation

    static let RemoveManifestation = baseUrl + "/user/remove_manifestation/"


    // update menifestation
    

    static let UpdateMenifestation = baseUrl + "/user/update_manifestation/"

    // Forgot Password
///user/forgot/password/email_pin
    static let ForGotPass = baseUrl + "/user/forgot/password/email_pin"
   
    // ResetPassword with pin
    
    static let ResetPassword = baseUrl +  "/user/reset/password/with/pin"
    
    // fetch All gratitude list
    ///user/list_gratitude
    
    static let AllGratitude = baseUrl + "/user/list_gratitude"


    // Add gratitude
    ///user/list_gratitude
    
    static let AddGratitude = baseUrl + "/user/add_gratitude"
    
    // remove gratitude
    
    
    static let RemoveGratitude = baseUrl + "/user/remove_gratitude/"
    
    ///user/update_gratitude/5b2ba3bad1ef647d0992a015
    //UpdateGratitude
    
    // remove gratitude
    
    
    static let UpdateGratitude = baseUrl + "/user/update_gratitude/"
    
    ///user/update/profile
    
    static let  EditProfile = baseUrl + "/user/update/profile"
    
    ///user/report
    
    static let  ReportProblem = baseUrl + "/user/report"
    
    ///user/get_preferences
    
    static let  GetPreferences = baseUrl + "/user/get_preferences"
    
    
    ///user/get_journal_images
    
    static let  GetJournal = baseUrl + "/user/get_journal_images"
    
    
    static let GetBookClub =   baseUrl + "/user/book_club"
    
    
    
    
}
