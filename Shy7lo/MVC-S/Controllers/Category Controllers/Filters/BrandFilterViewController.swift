//
//  BrandFilterViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/27/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class BrandFilterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    
    @IBOutlet var buDoneOutlet: UIButton!
    @IBOutlet var laclearAllFilter: UILabel!
    @IBOutlet var clearAllFilter: UIView!
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var TFView: DesignView!
    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laBrandFilter: UILabel!
    
    
    
    
    var imageView : UIImageView!
    var lang:String!
    var filterName:layeredDataObj?
    var brands = [optionsObj]()
    var brandsDictionary = [String: [optionsObj]]()
    var brandsSectionTitles = [String]()
    
    
    var selected_array_id = [String]()
    var selected_array_names = [String]()

    
    
    var code = [String]()
    var brandName:String!
    
    
    override func viewDidLoad() {
        
        print(self.filterName ?? "Khali")
        //load image
        self.loadImage()
        

        self.tabBarController?.tabBar.isHidden = true
        
        
        //get language from user defaults
        
        self.lang = UserInfoDefault.getLanguage()
        
        //search field delegate
        self.searchTF.delegate = self
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        let applyFilter :String = "ApplyFilter".localizableString(loc: lang)
        self.buttonApplyFilter.setTitle(applyFilter, for: .normal)
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        
        let buDone = "Done".localizableString(loc: lang)
        buDoneOutlet.setTitle(buDone, for: .normal)
        
        self.laBrandFilter.text = self.brandName.uppercased()
        self.laclearAllFilter.text = "ClearAllFilter".localizableString(loc: lang)
        
        //function call
        self.BrandCall()
        
        

        
        
        
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionIndexColor = UIColor.black
        
        
        //awake XIB
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(UINib(nibName: "CelarAllTableViewCell", bundle: nil), forCellReuseIdentifier: "CelarAllTableViewCell")
        
        //for clear filert selection
        let tapClearFilter = UITapGestureRecognizer(target: self, action: #selector(tapClearFilter(sender:)))
        self.clearAllFilter.addGestureRecognizer(tapClearFilter)
        self.clearAllFilter.isUserInteractionEnabled = true
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //==========================================================================================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        return self.brandsSectionTitles.count
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 2
        let brandKey = self.brandsSectionTitles[section]
        if let brandValues = self.brandsDictionary[brandKey] {
            return brandValues.count 
        }
        
        return 0
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for:indexPath) as! CategoryTableViewCell
        
        cell.selected_Category_lable.text = ""
        
        // Configure the cell...
        let brandKey = self.brandsSectionTitles[indexPath.section]
        if let brandValues = self.brandsDictionary[brandKey] {
            cell.laFilterName.text = brandValues[indexPath.row].label
       
            
        
            if selected_array_id.contains(brandValues[indexPath.row].id!) {
                cell.selecteedImage.isHidden = false
            }else{
                cell.selecteedImage.isHidden = true
            }
        
        
        
        }
        
        
        
        cell.tapView.tag =  indexPath.section*10000 + indexPath.row
        
        
        
        
        //for filert selection
        let tapFilterView = UITapGestureRecognizer(target: self, action: #selector(tapFilterView(sender:)))
        cell.tapView.addGestureRecognizer(tapFilterView)
        cell.tapView.isUserInteractionEnabled = true
        
        return cell
        
        
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.brandsSectionTitles
    }
    
    
    
    //======================================================================================
    @objc func tapFilterView(sender: UITapGestureRecognizer) {
        
        let cellTag = sender.view
        let index  = (cellTag?.tag)!  %  10000
        let section  = (cellTag?.tag)! / 10000
        
        
        print("ind \(index)   sec \(section) ")
        
        _ = IndexPath(row: index , section: section)
        
        
        
        let brandKey = self.brandsSectionTitles[section]
        if let brandValues = self.brandsDictionary[brandKey] {
            
            
            
            if selected_array_id.contains(brandValues[index].id!) {
                if let index = self.selected_array_id.index(of: brandValues[index].id!) {
                    self.selected_array_id.remove(at: index)
                }
            }else{
                self.selected_array_id.append(brandValues[index].id!)
            }
            
            
           
            if selected_array_names.contains(brandValues[index].label!) {
                if let index = self.selected_array_names.index(of: brandValues[index].label!) {
                    self.selected_array_names.remove(at: index)
                }
            }else{
                self.selected_array_names.append(brandValues[index].label!)
            }
            
           
            
            
        } //=---- ----  ----  ---  - - - - -
        
        
        
      
        
        self.tableView.reloadData()
        
        
        
        
    }
    //======================================================================================
    
    //back button
    @IBAction func buBack(_ sender: Any) {
       
        self.saveData()

        self.navigationController?.popViewController(animated: true)
   
    
    
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
    //=======================================================================================
    
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
    
    //==================================================================
    
    // for hide keyboard touch on scereen
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //=====================================================================
    //get brands from api
    
    func BrandCall() {
        
        for i in 0..<(self.filterName?.options?.count)!{
            self.brands.append((self.filterName?.options![i])!)
            print("Brands\(self.brands)")
        }
        
        // 1
        for brand in self.brands {
            let brandKey = String((brand.label?.prefix(1))!)
            if var brandValues = self.brandsDictionary[brandKey] {
                brandValues.append(brand)
                self.brandsDictionary[brandKey] = brandValues
            } else {
                self.brandsDictionary[brandKey] = [brand]
            }
        }
        
        // 2
        self.brandsSectionTitles = [String](self.brandsDictionary.keys)
        self.brandsSectionTitles = self.brandsSectionTitles.sorted(by: { $0 < $1 })
        
        
        
        if let array = categoryGlobeldata.mySelectedItemsIds[(filterName?.code)!] {
            self.selected_array_id = array 
        }
       
        if let array = categoryGlobeldata.mySelectedItemValues[(filterName?.code)!] {
            self.selected_array_names = array 
        }
        
        
        
        self.tableView.reloadData()
        
        
        
        
    }
    
    
    
    @IBAction func buApplyFilter(_ sender: Any) {
        
             self.saveData()
        
            categoryGlobeldata.applyFilterApi()
      
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(2) // views to pop
        navigationController?.setViewControllers(viewControllers!, animated: true)

//        for i in 0..<self.selectedIndex.count{
//            let cellIndex = selectedIndex[i]
//
//            print(cellIndex)
//            let cell: CategoryTableViewCell = self.tableView.cellForRow(at: cellIndex) as! CategoryTableViewCell
//            let name = cell.laFilterName.text
//            for j in 0..<(self.filterName?.options?.count)!{
//
//                if name == self.filterName?.options![j].label{
//
//                    self.code.append((self.filterName?.options![j].id)!)
//                }
//
//            }
//
//            print(self.code)
//        }
        
    }
    //============================================================
    @objc func tapClearFilter(sender: UITapGestureRecognizer) {
        self.code.removeAll()
        self.selected_array_id.removeAll()
       
        if let array = categoryGlobeldata.mySelectedItemsIds[(filterName?.code)!] {
            // self.selectedIndex = array
            categoryGlobeldata.mySelectedItemsIds.removeValue(forKey: (filterName?.code)!)
        }
        
        
        if let array = categoryGlobeldata.mySelectedItemValues[(filterName?.code)!] {
            // self.selectedIndex = array
            categoryGlobeldata.mySelectedItemValues.removeValue(forKey: (filterName?.code)!)
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    
    
    func saveData() {
        
        
        if self.selected_array_id.count > 0{
            categoryGlobeldata.mySelectedItemsIds[(filterName?.code)!] =  self.selected_array_id
        }else{
            // when user unselect all items
            if let array = categoryGlobeldata.mySelectedItemsIds[(filterName?.code)!] {
                // self.selectedIndex = array
                categoryGlobeldata.mySelectedItemsIds.removeValue(forKey: (filterName?.code)!)
                
            }
            
        }
        
        
        if self.selected_array_names.count > 0{
            categoryGlobeldata.mySelectedItemValues[(filterName?.code)!] =  self.selected_array_names
        }else{
            // when user unselect all items
            if let array = categoryGlobeldata.mySelectedItemValues[(filterName?.code)!] {
                // self.selectedIndex = array
                categoryGlobeldata.mySelectedItemValues.removeValue(forKey: (filterName?.code)!)
                
            }
            
        }
        
        
        
    }
    
    
    
    
    
    @IBAction func buDoneAction(_ sender: Any) {
        
        self.saveData()
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    
    
    
}
