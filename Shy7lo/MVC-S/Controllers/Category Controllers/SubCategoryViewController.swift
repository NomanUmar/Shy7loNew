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
    var SubCategoryId:String!
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
        
        //Name of category form previous controller
        self.categoryName.text = self.SubCategoryName.uppercased()
        tableView.register(UINib(nibName: "SubCategoryBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "SubCategoryBannerTableViewCell")
        
        tableView.register(UINib(nibName: "SubCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SubCategoryTableViewCell")
        
        
        //function call for load data
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
        let countBanner = self.banner.count
        let countCategory = self.categoriesAll.count
        return countCategory + countBanner
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if indexPath.row < self.banner.count{
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryBannerTableViewCell", for:indexPath) as! SubCategoryBannerTableViewCell
            
            bannerCell.bannerImage.tag = indexPath.row
            let postPicUrl =  URL(string: self.banner[indexPath.row].image!)!
            bannerCell.bannerImage.kf.setImage(with: postPicUrl, options: nil, progressBlock: nil) { (image, error, cacheType, postPicUrl ) in
                
            }
            
            return bannerCell
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
            cell.laSubCategoryName.text = self.categoriesAll[indexPath.row - banner.count].name
            let postPicUrl =  URL(string: self.categoriesAll[indexPath.row - banner.count].thumb!)!
            cell.subCategoryImage.kf.setImage(with: postPicUrl, options: nil, progressBlock: nil) { (image, error, cacheType, postPicUrl ) in
                
            }
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
                self.tableView.reloadData()
            }
        }
    }
    
    
    //for move next cotroller of category
    //get selected category id for make api call
    
    @objc func tapSubCategoryCell(sender: UITapGestureRecognizer) {
        //.. view all comment
        
        let categoryCellTag = sender.view
        
        
        let index  = (categoryCellTag?.tag)!
        print(index as Any)
        
    
    }
    
    @IBAction func buBack(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
}
