//
//  SearchViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/9/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCategoryViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var TFView: UIView!
    @IBOutlet var collectionview: UICollectionView!
    
    
    var categoryToScrtoll:Int!
    var imageView : UIImageView!
    var SubCategoryResponse:SubCategoriesResponse!
    var categoriesAll = [child_data_response]()
    var lang:String!
    var selected:Int!
    var indecator:UIView! = nil
    var cat_id: String!
    var catagoryArray = [BaseScreenObj]()
    var categoryName = [String]()
    var banner = [banner_response]()
    override func viewDidLoad() {
        //load image
        self.loadImage()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
   // self.categoryToScrtoll = UserInfoDefault.getCategoryIndex()
        
        tableView.register(UINib(nibName: "searchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchTableViewCell")
        
        tableView.register(UINib(nibName: "mainSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "mainSearchTableViewCell")
        
        //category id
        self.cat_id = UserInfoDefault.getCategoryID()
        //language
        self.lang = UserInfoDefault.getLanguage()
        
        //function call for category id
        self.getUrl_and_Load(cat_id: cat_id!)
        
        
        
        //Api category data
        
        //search text field delegate
        searchTF.delegate = self
        
        //collection view delegate
        collectionview.delegate = self
        collectionview.dataSource = self
        
        //function call for load data
        self.apiCategoryData(id: self.cat_id)
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.defaultTabSelection()
        
        
    }
    
    //=====================================================================
   // for hide keyboard touch on scereen
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //=====================================================================
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=================================================================
    //collection view & category tab
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.catagoryArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
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
        let categoryId = self.catagoryArray[indexPath.row].category_id
        UserInfoDefault.saveCategoryID(categoryID: categoryId)
        self.apiCategoryData(id: categoryId)
        //UserInfoDefault.saveCategoryIndex(CategoryIndex: indexPath.row)
        
        //let cell = collectionView.cellForItem(at: indexPath) as? MianCategoryCollectionViewCell
        //cell?.laCategoryName.textColor = .black
        
    }
    
   /* override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: self.categoryToScrtoll, section: 0)
        self.collectionview.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }*/
    //=================================================================
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           let countBanner = self.banner.count
           let countCategory = self.categoriesAll.count
            return countCategory + countBanner
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if indexPath.row < self.banner.count{
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "mainSearchTableViewCell", for:indexPath) as! mainSearchTableViewCell
            
            bannerCell.mainView.tag = indexPath.row
            let postPicUrl =  URL(string: self.banner[indexPath.row].image!)!
            bannerCell.bannerImage.kf.setImage(with: postPicUrl, options: nil, progressBlock: nil) { (image, error, cacheType, postPicUrl ) in
                
            }
            
            return bannerCell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for:indexPath) as! searchTableViewCell
            print("Row---->")
            print(indexPath.row)
            
            cell.categoryView.tag = indexPath.row
            //for cell selection
            let tapCategoryView = UITapGestureRecognizer(target: self, action: #selector(tapCategoryCell(sender:)))
            cell.categoryView.addGestureRecognizer(tapCategoryView)
            cell.categoryView.isUserInteractionEnabled = true
            //end for cell selection
            cell.lacategoryName.text = self.categoriesAll[indexPath.row - banner.count].name
            let postPicUrl =  URL(string: self.categoriesAll[indexPath.row - banner.count].thumb!)!
            cell.categoryImage.kf.setImage(with: postPicUrl, options: nil, progressBlock: nil) { (image, error, cacheType, postPicUrl ) in
                
            }
            return cell
        }
   
        }
    
    //=================================================================
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
    
    //==================================================================
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
                    
                    
                } //  if condition
                
            } // foor loop
            
            
            
            
            
        } // api init response
        
    } //  function
    
    //===============================================================
    func defaultTabSelection(){
        //default selected category
        let indexPathForFirstRow = IndexPath(row: (self.selected), section: 0)
        self.collectionview.selectItem(at: indexPathForFirstRow, animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
        collectionView(self.collectionview, didSelectItemAt: indexPathForFirstRow)
    }
 //get data of  sub category
    
    func apiCategoryData(id:String){
        
        ApisCallingClass.getSubCategoriesID(id: id ) { (data) in
            if(data != nil){
                self.SubCategoryResponse = data
                self.categoriesAll = (self.SubCategoryResponse.data?.category?.child_data!)!
                self.banner = (self.SubCategoryResponse.data?.category?.banner!)!
                self.tableView.reloadData()
            }
        }
    }
    
    //===================================================================
    //for move next cotroller of category
    //get selected category id for make api call
    
    @objc func tapCategoryCell(sender: UITapGestureRecognizer) {
        //.. view all comment
        self.view.endEditing(true)
        
        let categoryCellTag = sender.view
        
       
        let index  = (categoryCellTag?.tag)!
        print(index as Any)
        // for ignore intrection until response not back
        UIApplication.shared.beginIgnoringInteractionEvents()
         let selectedCategoryID = self.categoriesAll[index - self.banner.count].id
        //check selected category have sub category or not
        ApisCallingClass.getSubCategoriesID(id: selectedCategoryID!) { (data) in
            
            
            let res : SubCategoriesResponse = data!
           
            if (res.data?.category?.child_data?.isEmpty)!{
                //end ignoring intrection
                UIApplication.shared.endIgnoringInteractionEvents()
                self.showToast(message: "no sub category")
            }else{
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SubCategoryViewController") as! SubCategoryViewController
                vc.SubCategoryId = selectedCategoryID
                vc.SubCategoryName =  self.categoriesAll[index - self.banner.count].name
                //end ignoring intrection
            
                UIApplication.shared.endIgnoringInteractionEvents()
                self.navigationController?.pushViewController(vc,animated: true)
            }
            
            
        }
        
       
        
    }
}
