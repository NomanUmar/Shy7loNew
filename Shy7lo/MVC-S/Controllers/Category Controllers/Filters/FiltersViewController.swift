//
//  FiltersViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/21/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FiltersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,RangeSeekSliderDelegate {
    
    
    @IBOutlet var clearAllFilter: UIView!
    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laFilter: UILabel!
    
    
    var filterRespose:FilterResponse?
    var currancy : String!
    var lang:String!
    var filterName = [String]()
    var categoryId:String!
  
    
    override func viewDidLoad() {
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        //get language from user defaults
        
        self.lang = UserInfoDefault.getLanguage()
        
        //get currency
        if lang.contains("ar"){
            self.currancy = UserInfoDefault.getCurrancyArabic()
        }else{
            self.currancy = UserInfoDefault.getCurrancyEnglish()
        }
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        let applyFilter :String = "ApplyFilter".localizableString(loc: lang)
        self.buttonApplyFilter.setTitle(applyFilter, for: .normal)
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        
        self.laFilter.text = "FilterFVC".localizableString(loc: lang)
        
        self.getFilter(id: self.categoryId)
        
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        //awake XIB
        
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        tableView.register(UINib(nibName: "CelarAllTableViewCell", bundle: nil), forCellReuseIdentifier: "CelarAllTableViewCell")
        //priceRangeTableViewCell
        tableView.register(UINib(nibName: "priceRangeTableViewCell", bundle: nil), forCellReuseIdentifier: "priceRangeTableViewCell")
        //for clear filert selection
        let tapClearFilter = UITapGestureRecognizer(target: self, action: #selector(tapClearFilter(sender:)))
        self.clearAllFilter.addGestureRecognizer(tapClearFilter)
        self.clearAllFilter.isUserInteractionEnabled = true
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
//        let check = UserDefaults.standard.bool(forKey: "gotoProduct")
//        if check
//        {
//            UserDefaults.standard.removeObject(forKey: "gotoProduct")
//            self.navigationController?.popViewController(animated: true)
//
//        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //======================================================================================
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.filterName.isEmpty{
            return 0
        }else{
            return self.filterName.count + 1
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == filterName.count{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "priceRangeTableViewCell", for:indexPath) as! priceRangeTableViewCell
            
            cell.priceRangeView.delegate = self
            cell.minPrice.text =   "0.00"
            cell.maxPrice.text =   "1000"
            cell.currencyMin.text = self.currancy + " "
            cell.currencyMax.text = self.currancy + " "
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for:indexPath) as! FilterTableViewCell
            
            cell.laFilterName.text = self.filterName[indexPath.row]
            let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
            cell.buttonNext.setImage(flippedImage, for: .normal)
            
            cell.tapView.tag = indexPath.row
            
            
            //for filert selection
            let tapFilterView = UITapGestureRecognizer(target: self, action: #selector(tapFilterView(sender:)))
            
            cell.tapView.addGestureRecognizer(tapFilterView)
            cell.tapView.isUserInteractionEnabled = true
            
            if let array = categoryGlobeldata.mySelectedItemValues[ (self.filterRespose?.data?.layeredData![indexPath.row].code)!] {
    
                var text  = ""
                for (i, name) in array.enumerated() {
                    if i == 0{
                   text = name
                    }else{
                        text = text + "," + name
                    }
                }
                cell.selected_Category_lable.text = text

            
            
            }else{
                cell.selected_Category_lable.text = ""
            }
            
            
            
            
            return cell
        }
        
    }
    //======================================================================================
    @objc func tapFilterView(sender: UITapGestureRecognizer) {
        
        let cellTag = sender.view
        
        
        let index  = (cellTag?.tag)!
        print(index as Any)
        //start ignoring intrection
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.endEditing(true)
        if index == 0{
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CategoryFilterViewController") as! CategoryFilterViewController
            //end ignoring intrection
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.navigationController?.pushViewController(vc,animated: true)
            
            
        }else {
            var code:String!
            UIApplication.shared.endIgnoringInteractionEvents()
            //let cellIndex = IndexPath(row: index , section: 0)
            //let cell: CategoryTableViewCell = self.tableView.cellForRow(at: cellIndex) as! CategoryTableViewCell
            for i in 0..<(self.filterRespose?.data?.layeredData?.count)!{
                
                if self.filterName[index] == (self.filterRespose?.data?.layeredData![i].label)!{
                    
                    code = (self.filterRespose?.data?.layeredData![i].code)!
                    
                    if code == "brand"{
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "BrandFilterViewController") as! BrandFilterViewController
                        vc.filterName = (self.filterRespose?.data?.layeredData![i])!
                        vc.brandName = (self.filterRespose?.data?.layeredData![i].label)!
                        print((self.filterRespose?.data?.layeredData![i])!)
                        //end ignoring intrection
                        
                        self.navigationController?.pushViewController(vc,animated: true)
                        
                    }else{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionFilterViewController") as! CollectionFilterViewController
                        vc.filterName = (self.filterRespose?.data?.layeredData![i])!
                        vc.filterLableName = (self.filterRespose?.data?.layeredData![i].label)!
                        //end ignoring intrection
                        
                        self.navigationController?.pushViewController(vc,animated: true)
                    }
                    
                }
                
            }
            
        }
    }
    
    
    
    //======================================================================================
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        
        print("min \(minValue)   max \(maxValue)")
        
        let index  = filterName.count
        print(index as Any)
        
        let cellIndex = IndexPath(row: index , section: 0)
        
        let cell: priceRangeTableViewCell = self.tableView.cellForRow(at: cellIndex) as! priceRangeTableViewCell
        
        let minPrice = String(format: "%.2f", minValue)
        let maxPrice = String(format: "%.2f", maxValue)
        
        
        
        cell.maxPrice.text =  "\(maxPrice)"
        cell.minPrice.text = "\(minPrice)"

    }
    
    
    //======================================================================================
    
    //back button
    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getFilter(id:String ){
        ApisCallingClass.getFilter(id: id, sort_by: "created_at", direction: "DESC", filter: "") { (data) in
            let res:FilterResponse = data!
            self.filterRespose = res
            
            for i in 0..<(res.data?.layeredData?.count)!{
                
                let name = res.data?.layeredData![i].label
                let code = res.data?.layeredData![i].code
                if  code  != "price" {
                    self.filterName.append(name!)
                }
                
            }
            self.tableView.reloadData()
        }
    }
    //============================================================
    @objc func tapClearFilter(sender: UITapGestureRecognizer) {
        
        
    }
    
    @IBAction func buApplyFilter(_ sender: Any) {
        
        categoryGlobeldata.applyFilterApi()
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
}
