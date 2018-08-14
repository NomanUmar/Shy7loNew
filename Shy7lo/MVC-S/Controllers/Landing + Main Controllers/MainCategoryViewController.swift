//
//  MainCategoryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/3/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class MainCategoryViewController: UIViewController,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var landingWebView: UIWebView!
    @IBOutlet var TFView: UIView!
    @IBOutlet var collectionview: UICollectionView!
    
    var lang:String!
    var selected:Int!
    var indecator:UIView! = nil
    var imageView : UIImageView!
    var cat_id: String!
    var catagoryArray = [BaseScreenObj]()
    var categoryName = [String]()
    var categoryToScrtoll:Int!
    override func viewDidLoad() {
        //load image
        
        self.loadImage()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.categoryToScrtoll = UserInfoDefault.getCategoryIndex()
        
        
        self.cat_id = UserInfoDefault.getCategoryID()
        self.lang = UserInfoDefault.getLanguage()
        
        landingWebView.delegate = self
        landingWebView.scalesPageToFit = false
        landingWebView.isMultipleTouchEnabled = false
        landingWebView.scrollView.bounces =  false
        
        //function call for category id
        self.getUrl_and_Load(cat_id: cat_id!)
        
        
        //cllection view delegates
        collectionview.delegate = self
        collectionview.dataSource = self
        //text field delegate
        
        searchTF.delegate = self
        
        self.defaultTabSelection()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        if navigationType == .linkClicked
        {
            print("Clicked")
            print(request.url!)
    
            
        }
        return true
    }
    //=====================================================================
    // for hide keyboard touch on scereen
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //=====================================================================
    
    func webViewDidStartLoad(_ webView: UIWebView) {
      //  self.indecator = UIViewController.displaySpinner(onView: self.view)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
       // UIViewController.removeSpinner(spinner: self.indecator)
        
    }
    
    //=======================================================================================
    
    func getUrl_and_Load (cat_id:String)  {
        let data = UserDefaults.standard.value(forKey:"AppInit") as? Data
        let jsonDecoder = JSONDecoder()
        if let res = try? jsonDecoder.decode ( AppInitResponse.self , from: data!  ) as   AppInitResponse {
            
            
            for j in 0..<res.landing_screens.base_screens.count{
                print(j)
                if lang.contains("ar"){
                    categoryName.append(res.landing_screens.base_screens[j].title_ar)
                }else{
                    categoryName.append(res.landing_screens.base_screens[j].title_en)
                }
            }
            
           self.collectionview.reloadData()
            self.catagoryArray =  res.landing_screens.base_screens
            for i in 0..<self.catagoryArray.count {
                let obj = self.catagoryArray[i]
                
                if obj.category_id == cat_id {
                    
                self.selected = i
                self.loadUrl(url:obj.url)
                    
                    
                } //  if condition
                
            } // foor loop
            
            
            
            
            
        } // api init response
        
    } //  function
    
    //=================================================================================
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.catagoryArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MianCategoryCollectionViewCell", for: indexPath) as! MianCategoryCollectionViewCell
        
       
       
        
        cell.laCategoryName.text = self.categoryName[indexPath.row].uppercased()
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = self.collectionview.bounds.width/3.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        var url:String!
        if lang.contains("ar"){
        url = self.catagoryArray[indexPath.row].url_ar
        }else{
            url = self.catagoryArray[indexPath.row].url
        }
        self.loadUrl(url: url)
        let categoryId = self.catagoryArray[indexPath.row].category_id
        UserInfoDefault.saveCategoryID(categoryID: categoryId)
        //UserInfoDefault.saveCategoryIndex(CategoryIndex: indexPath.row)

         //let cell = collectionView.cellForItem(at: indexPath) as? MianCategoryCollectionViewCell
        //cell?.laCategoryName.textColor = .black

    }
  /*  override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: self.categoryToScrtoll, section: 0)
        self.collectionview.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }*/
    
    //======================================================
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        
        
        self.imageAnimate()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            self.returnImageAnimate()
            self.searchTF.endEditing(true)
        }else{
            self.searchTF.resignFirstResponder()
            self.searchTF.endEditing(true)
            
        }
        return true
    }
    
    //======================================================
    
    func loadUrl(url:String){
        
        let url = URL(string: url)
        landingWebView.loadRequest(URLRequest(url: url!))
    }
    
    //=================================================================
    //functions for image in text field
    func loadImage(){
 
        self.imageView  = UIImageView(frame: CGRect(x: 0 , y: 7, width: 20 , height: 20))
        self.imageView.center.x = self.view.center.x
        
        
        self.imageView.image = UIImage(named: "CategorySearch")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        
        
        self.TFView.addSubview(imageView)
    }
    
    func imageAnimate(){
        
        UIView.animate(withDuration: 0.8 , animations: {
        }, completion: {(isCompleted) in
            self.imageView.frame = CGRect(x: 7 , y: 7, width: 20 , height: 20)
            
        })
     
    }
    
    func returnImageAnimate(){
        
        UIView.animate(withDuration: 0.8 , animations: {
        }, completion: {(isCompleted) in
            self.imageView.frame = CGRect(x: 0 , y: 7, width: 20 , height: 20)
            
            self.imageView.center.x = self.TFView.center.x
        })
        
    }
    
    func defaultTabSelection(){
    //default selected category
    let indexPathForFirstRow = IndexPath(row: (self.selected), section: 0)
    self.collectionview.selectItem(at: indexPathForFirstRow, animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
    collectionView(self.collectionview, didSelectItemAt: indexPathForFirstRow)
    }
}
