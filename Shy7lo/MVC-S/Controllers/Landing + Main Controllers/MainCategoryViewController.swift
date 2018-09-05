//
//  MainCategoryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/3/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class MainCategoryViewController: UIViewController,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    @IBOutlet var Activity: UIActivityIndicatorView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var landingWebView: UIWebView!
    @IBOutlet var TFView: UIView!
    @IBOutlet var collectionview: UICollectionView!
    
    var lang:String!
    var selected:Int!
    var imageView : UIImageView!
    var cat_id: String!
    var catagoryArray = [BaseScreenObj]()
    var categoryName = [String]()
    var categoryToScrtoll:Int!
    override func viewDidLoad() {
        
        // tab in collection view every time show 3 cell
        let numberOfCellsPerRow: CGFloat = 3
        
        
        if let flowLayout = collectionview?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .horizontal ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
        
        //load image
        self.loadImage()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // self.categoryToScrtoll = UserInfoDefault.getCategoryIndex()
        
        let  transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.Activity.transform = transform
        self.cat_id = UserInfoDefault.getCategoryID()
        self.lang = UserInfoDefault.getLanguage()
        
        landingWebView.delegate = self
        landingWebView.scalesPageToFit = false
        landingWebView.isMultipleTouchEnabled = false
        landingWebView.scrollView.bounces =  false
        
        //function call for category id
        self.getUrl_and_Load(cat_id: cat_id!)
        
        if lang.contains("ar"){
            self.collectionview.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        }
        //cllection view delegates
        collectionview.delegate = self
        collectionview.dataSource = self
        
        self.defaultTabSelection()
        //text field delegate
        
        searchTF.delegate = self
        
        
        
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
            print(self.categoryName)
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
        print(indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MianCategoryCollectionViewCell", for: indexPath) as! MianCategoryCollectionViewCell
        
        
        cell.laCategoryName.text = self.categoryName[indexPath.row].uppercased()
        
        
        
        return cell
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
        
        //  function call to auto scroll category tab
        self.scroll(indexPath: indexPath.row)
        
        self.landingWebView.loadRequest(URLRequest.init(url: URL.init(string: "about:blank")!))
        var url:String!
        if lang.contains("ar"){
            url = self.catagoryArray[indexPath.row].url_ar
        }else{
            url = self.catagoryArray[indexPath.row].url
        }
        self.loadUrl(url: url)
        let categoryId = self.catagoryArray[indexPath.row].category_id
        UserInfoDefault.saveCategoryID(categoryID: categoryId)
        
        
    }
    
    
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
        var urlRequest = URLRequest(url: url!)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        landingWebView.loadRequest(urlRequest)
        
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.Activity.isHidden = false
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.Activity.isHidden = true
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
            if self.lang.contains("ar"){
                self.imageView.frame = CGRect(x: self.view.bounds.width - 50 , y: 7, width: 20 , height: 20)
            }
            else{
                self.imageView.frame = CGRect(x: 7 , y: 7, width: 20 , height: 20)
            }
            
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
        let indexPathFirstRow = IndexPath(row: (self.selected), section: 0)
        self.collectionview.selectItem(at: indexPathFirstRow, animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
        collectionView(self.collectionview, didSelectItemAt: indexPathFirstRow)
        
    }
    // to auto scroll category tab
    
    func scroll (indexPath:Int){
        self.categoryToScrtoll =  indexPath
        let index = self.catagoryArray.count
        
        if indexPath < index/2{
            if indexPath   != 0 &&  indexPath > 0 {
                let indexPath = IndexPath(item: self.categoryToScrtoll - 1, section: 0)
                self.collectionview.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
            }
            
        }else{
            
            if self.categoryToScrtoll + 1 < self.catagoryArray.count {
                let indexPath = IndexPath(item: self.categoryToScrtoll + 1, section: 0)
                self.collectionview.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
            }
            
        }
        print(indexPath)
        print(self.catagoryArray.count)
        if indexPath + 1 == self.catagoryArray.count  {
            let indexPath = IndexPath(item: indexPath , section: 0)
            self.collectionview.scrollToItem(at: indexPath , at: [.centeredHorizontally], animated: true)
        }
        if indexPath  == 0 {
            let indexPath = IndexPath(item: indexPath , section: 0)
            self.collectionview.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
        }
    }
}
