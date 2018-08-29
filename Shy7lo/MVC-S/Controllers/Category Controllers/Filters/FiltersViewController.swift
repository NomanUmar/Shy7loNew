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
    
    
    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laFilter: UILabel!
    
    var currancy : String!
    var lang:String!
    var filterName = ["Category","Collection","Brand","Color","Size"]

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
        
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        //awake XIB
        
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        tableView.register(UINib(nibName: "CelarAllTableViewCell", bundle: nil), forCellReuseIdentifier: "CelarAllTableViewCell")
        //priceRangeTableViewCell
        tableView.register(UINib(nibName: "priceRangeTableViewCell", bundle: nil), forCellReuseIdentifier: "priceRangeTableViewCell")
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//======================================================================================

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.filterName.count + 2
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        if indexPath.row == 0{
             let cell = tableView.dequeueReusableCell(withIdentifier: "CelarAllTableViewCell", for:indexPath) as! CelarAllTableViewCell
            
            cell.laClearFilters.text = "ClearFilter".localizableString(loc: self.lang)
            //for filert selection
            let tapFilterView = UITapGestureRecognizer(target: self, action: #selector(tapFilterView(sender:)))
            cell.tapView.addGestureRecognizer(tapFilterView)
            cell.tapView.isUserInteractionEnabled = true
            
            return cell
        }else if indexPath.row == filterName.count + 1{
            
            
             let cell = tableView.dequeueReusableCell(withIdentifier: "priceRangeTableViewCell", for:indexPath) as! priceRangeTableViewCell
            
             cell.priceRangeView.delegate = self
            cell.minPrice.text =   "0.00"
            cell.maxPrice.text =   "1000"
            cell.currencyMin.text = self.currancy + " "
            cell.currencyMax.text = self.currancy + " "

            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for:indexPath) as! FilterTableViewCell
        
        cell.laFilterName.text = self.filterName[indexPath.row - 1].localizableString(loc: self.lang)
        let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
        cell.buttonNext.setImage(flippedImage, for: .normal)
        
        cell.tapView.tag = indexPath.row
        
        
        //for filert selection
        let tapFilterView = UITapGestureRecognizer(target: self, action: #selector(tapFilterView(sender:)))
        cell.tapView.addGestureRecognizer(tapFilterView)
        cell.tapView.isUserInteractionEnabled = true
            
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
        if index == 0
        {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        else if index == 1{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CategoryFilterViewController") as! CategoryFilterViewController
            
            //end ignoring intrection
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.navigationController?.pushViewController(vc,animated: true)
            
            
        }else if index == 2 {
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CollectionFilterViewController") as! CollectionFilterViewController
            
            //end ignoring intrection
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.navigationController?.pushViewController(vc,animated: true)
            
            
        }else if index == 3{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BrandFilterViewController") as! BrandFilterViewController
            
            //end ignoring intrection
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.navigationController?.pushViewController(vc,animated: true)
            
        }else if index == 4{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
            
            //end ignoring intrection
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.navigationController?.pushViewController(vc,animated: true)
            
        }
        else if index == 5 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SizeViewController") as! SizeViewController
            
            //end ignoring intrection
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.navigationController?.pushViewController(vc,animated: true)
            
            
        }
        
    }
    
    
    
//======================================================================================
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        
        print("min \(minValue)   max \(maxValue)")
        
        let index  = filterName.count + 1
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

}
