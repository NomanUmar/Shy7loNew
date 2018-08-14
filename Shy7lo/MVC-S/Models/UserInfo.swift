//
//  UserInfo.swift
//  idol
//
//  Created by Sajjad Yousaf on 5/29/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
struct AppInit: Codable {
    
    var device_token:String
    var device_type:String
    var app_version: String
    var country:String
    
}
struct AppInitResponse : Codable{
    var landing_screens: LandingScreen
    var api_token : String
    var success : Int
    var integrations : IntegrationObj
    var stores : [StoresObj]
    var currencies : CurrencieObj
    var countries : [CountriesObj]
    
    
}
struct LandingScreen : Codable{
    
    var base_screens : [BaseScreenObj]
    var child_screens: [ChildScreenObj]
    
}


struct BaseScreenObj : Codable{
    
    var category_id : String
    var title_en: String
    var title_ar:String
    var url : String
    var url_ar : String
    
}


struct ChildScreenObj : Codable{
    
    
    var category_id : String?
    var title_en : String
    var title_ar : String
    var url : String
    var url_ar : String
    
    
}

struct IntegrationObj : Codable{
    var adjust : String
    var one_sginal: String
    var fabric : String
    var criteo : String
    
    
}
struct StoresObj : Codable{
    var id : Int
    var code: String
    var website_id : Int
    var locale : String
    var base_currency_code : String
    var default_display_currency_code: String
    var timezone :String
    var weight_unit : String
    var base_url : String
    var base_link_url : String
    var base_static_url :String
    var base_media_url :String
    var secure_base_url:String
    var secure_base_link_url :String
    var secure_base_static_url:String
    var secure_base_media_url:String
    
    
    
}


struct CurrencieObj : Codable{
    
    var base_currency_code : String
    var base_currency_symbol: String
    var default_display_currency_code: String
    var default_display_currency_symbol :String
    var available_currency_codes : [String]
    var exchange_rates : [ExchangeRateObj]

}

struct ExchangeRateObj : Codable{
    var currency_to : String
    var rate: Float
   
    
}

struct CountriesObj : Codable{
    var id : String
    var two_letter_abbreviation: String
    var three_letter_abbreviation : String
    var full_name_locale :String
    var full_name_english :String
    var available_regions : [AvailableRegionsObj]?
    var currency_en : String
    var currency_ar : String
    var exchange_rate : Float
    
    
}

struct AvailableRegionsObj : Codable{
    var id : String
    var code: String
    var name : String
    
}

struct ErrorString : Codable{
    var message : String
    
}


