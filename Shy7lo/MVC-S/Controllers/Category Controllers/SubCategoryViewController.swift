//
//  SubCategoryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/10/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var tableView: UITableView!
    var lang:String!
    var SubCategoryId:String!
    var indecator:UIView? = nil
    var categoriesAll = [child_data_response]()
    var banner = [banner_response]()
    var SubCategoryResponse:SubCategoriesResponse!
    var SubCategoryName:String!

    override func viewDidLoad() {
        
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.lang = UserInfoDefault.getLanguage()
        
        //Name of category form previous controller
        self.categoryName.text = self.SubCategoryName.uppercased()
        tableView.register(UINib(nibName: "SubCategoryBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "SubCategoryBannerTableViewCell")
        //ViewAllTableViewCell
        
        tableView.register(UINib(nibName: "SubCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SubCategoryTableViewCell")
        
        tableView.register(UINib(nibName: "ViewAllTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewAllTableViewCell")
        
        
        //function call for load data
        self.indecator = UIViewController.displaySpinner(onView: self.view)
        self.apiCategoryData(id: self.SubCategoryId)
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //=================================================================
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.categoriesAll.count != 0 || banner.count != 0{
        let countBanner = self.banner.count
        let countCategory = self.categoriesAll.count
            return countCategory + countBanner + 1
            
        }else{
            return 0
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row < self.banner.count{
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryBannerTableViewCell", for:indexPath) as! SubCategoryBannerTableViewCell
            
            bannerCell.bannerImage.tag = indexPath.row
            let postPicUrl =  URL(string: self.banner[indexPath.row].image!)!
            bannerCell.bannerImage.kf.setImage(with: postPicUrl, options: nil, progressBlock: nil) { (image, error, cacheType, postPicUrl ) in
                
            }
            
            return bannerCell
        }else if indexPath.row == self.banner.count{
            //ViewAllTableViewCell
            
            
            let viewAllCell = tableView.dequeueReusableCell(withIdentifier: "ViewAllTableViewCell", for:indexPath) as! ViewAllTableViewCell
            viewAllCell.laViewAll.text = "ViewAllSubCategoryvc".localizableString(loc: lang)
            viewAllCell.ViewAllView.tag = indexPath.row
            let tapViewAll = UITapGestureRecognizer(target: self, action: #selector(tapViewAllCell(sender:)))
            viewAllCell.ViewAllView.addGestureRecognizer(tapViewAll)
            viewAllCell.ViewAllView.isUserInteractionEnabled = true
            
           
            return viewAllCell
            
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryTableViewCell", for:indexPath) as! SubCategoryTableViewCell
            print("Row---->")
            print(indexPath.row)
            
            cell.subCategoryView.tag = indexPath.row
            //for cell selection
            let tapCategoryView = UITapGestureRecognizer(target: self, action: #selector(tapSubCategoryCell(sender:)))
            cell.subCategoryView.addGestureRecognizer(tapCategoryView)
            cell.subCategoryView.isUserInteractionEnabled = true
            //end for cell selection
            cell.laSubCategoryName.text = self.categoriesAll[(indexPath.row - 1 ) - banner.count].name
            let postPicUrl =  URL(string: self.categoriesAll[(indexPath.row - 1) - banner.count].thumb!)!
          
                cell.subCategoryImage.kf.indicatorType = .activity
                cell.subCategoryImage.kf.setImage(with: postPicUrl)

            
            cell.subCategoryImage.maskCircle()
            return cell
        }
        
    }
    
    //=================================================================
    func apiCategoryData(id:String){
        
        ApisCallingClass.getSubCategoriesID(id: id ) { (data) in
            if(data != nil){
                self.SubCategoryResponse = data
                self.categoriesAll = (self.SubCategoryResponse.data?.category?.child_data!)!
                self.banner = (self.SubCategoryResponse.data?.category?.banner!)!
                UIViewController.removeSpinner(spinner: self.indecator!)
                self.tableView.reloadData()
            }
        }
    }
    
    
    //for move next cotroller of category
    //get selected category id for make api call
    
    @objc func tapSubCategoryCell(sender: UITapGestureRecognizer) {
        //.. view all comment
        
        let categoryCellTag = sender.view
        
        //start ignoring intrection
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        
        let index  = (categoryCellTag?.tag)!
        print(index as Any)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as!  ProductViewController
           vc.subCategoryId =  self.categoriesAll[index - self.banner.count - 1].id
           vc.subCategoryName = self.categoriesAll[index - self.banner.count - 1].name
        
        
        
        //end ignoring intrection
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        self.navigationController?.pushViewController(vc,animated: true)
    
    }
    
    @objc func tapViewAllCell(sender: UITapGestureRecognizer) {
        //.. view all comment
        
        let viewAllCellTag = sender.view
        
        
        let index  = (viewAllCellTag?.tag)!
        print(index as Any)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as!  ProductViewController
        vc.subCategoryId =  self.SubCategoryId
        vc.subCategoryName = self.SubCategoryName
        
        print(self.SubCategoryId)
        print(self.SubCategoryName)
        
       
        //end ignoring intrection
        UIApplication.shared.endIgnoringInteractionEvents()
        self.navigationController?.pushViewController(vc,animated: true)
        
        
    }
    
    @IBAction func buBack(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
}
