//
//  LeandingViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/1/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import WebKit

class LandingViewController: UIViewController,UIWebViewDelegate {

    
    var window: UIWindow?
    var indecator:UIView! = nil
    var lang: String!
    @IBOutlet var landingWebView: UIWebView!
    
    override func viewDidLoad() {
        //get language from user defaults
        lang = UserInfoDefault.getLanguage()
        //web view delegate
        landingWebView.delegate = self
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        
        // for status bar show in webview
        
        landingWebView.scrollView.contentInsetAdjustmentBehavior = .never
        
        //for off zooming of web view
        
        landingWebView.scalesPageToFit = false
        landingWebView.isMultipleTouchEnabled = false
        
        //ofe scrolling
        landingWebView.scrollView.isScrollEnabled = false
        landingWebView.scrollView.bounces =  false
        
    
        self.loadUrl()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
      //  indecator = UIViewController.displaySpinner(onView: self.view)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
      //   UIViewController.removeSpinner(spinner: indecator)
        
    }
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        if navigationType == .linkClicked
        {
            print("Clicked")
            print(request.url!)
            let url =  request.url
            let newUrl =  String(describing: url!)
            if newUrl.contains("cat_id") || newUrl.contains("category_id"){
            // if else for get category id id arabic so category_id else cat_id
            if lang.contains("ar"){
            let cat_id = url?.valueOf("category_id")
            print("\(String(describing: cat_id))")
             UserInfoDefault.saveCategoryID(categoryID: cat_id!)
            }else{
                let cat_id = url?.valueOf("cat_id")
                print("\(String(describing: cat_id))")
                UserInfoDefault.saveCategoryID(categoryID: cat_id!)
            }
                let mytabbar = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                let appDelegate = UIApplication.shared.delegate  as! AppDelegate
                appDelegate.window?.rootViewController = mytabbar
            }
           
        
          
          
        
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadUrl(){
        
        
        
        
        var url:URL!
        if lang.contains("ar"){
         url = URL(string: AdditionalURLs.LandingScreen + "ar")
        }else{
             url = URL(string: AdditionalURLs.LandingScreen + "en")
        }
        
        landingWebView.loadRequest(URLRequest(url: url))
    }
}





