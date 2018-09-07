//
//  CategoryTab.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 9/5/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation

class categoryGlobeldata : NSObject {
    
   // static var categoryResponse:categoryResponse?
   
    static var categoryResponse:categoryDataObj?
    
    
   //---------------------------------------------------------------
    static var myArray = [categoryDataObj]()
    // it contains child selected category array with respect to parent , that will while navigating on screens
  
    static var mySelectedCategoryDic_refByParent = [Int: [Int]] ()
    // contains id of as a whole selected category
    static var mySelectedCategorryArray = [Int]()
    static var mySelectedCategoryDic_Path = [String: [categoryDataObj]] ()

   //----------------------------------------------------------------
    
   
    //----------------------------------------------------------------
    static var mySelectedItemsIds  = [String: [String]] ()
    static var mySelectedItemValues  = [String: [String]] ()
    //----------------------------------------------------------------
    
    static var categoryString = ""
    static var filterUrlString = ""

    
   static func applyFilterApi(){
        
    
    
   categoryString = ""
   filterUrlString = ""

    
    
    var tempInt = mySelectedCategorryArray
    for (code, idAraay) in mySelectedCategoryDic_refByParent {
        print("\(code) :  \(idAraay) ")
        tempInt = tempInt + idAraay
    }
    
    for (index, element) in tempInt.enumerated() {
        if index == 0 {
            categoryString = "\(categoryString)\(element)"
        }else{
            categoryString = "\(categoryString),\(element)"
        }
    }
    
    
        var Child_Filter_String = ""
        for (code, idAraay) in mySelectedItemsIds {
            print("--> \(code) :  \(idAraay) ")
    
            for (index, element) in idAraay.enumerated() {
    
                if index == 0 {
                    Child_Filter_String = "filter[\(code)]=\(element)"
                }else{
                    Child_Filter_String = "\(Child_Filter_String),\(element)"
                }
    
            }
        
            
            if filterUrlString.isEmpty{
                  filterUrlString = Child_Filter_String
            }else{
                  filterUrlString = "\(filterUrlString)&\(Child_Filter_String)"
            }
       
            
    }
  
//    print("..\(categoryString) ")
//    print("..\(filterUrlString) ")
//    print("..\n \n  ")
//

     UserDefaults.standard.set(true, forKey: "useCustomFilters")
    
 }
    
    
    
    
    
    
    
    
}
