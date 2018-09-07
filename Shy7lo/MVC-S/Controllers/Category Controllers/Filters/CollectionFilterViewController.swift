//
//  CollectionFilterViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/27/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CollectionFilterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var clearAllFilter: UIView!
    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laCollectionFilter: UILabel!
    
    var selected_array_id = [String]()
    var selected_array_names = [String]()

    
    
    var filterName:layeredDataObj?
    var lang:String!
    var filterLabel = [String]()
    var ids = [String]()
    var filterLableName:String!
    
    override func viewDidLoad() {
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        //get language from user defaults
        
        self.lang = UserInfoDefault.getLanguage()
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        let applyFilter :String = "ApplyFilter".localizableString(loc: lang)
        self.buttonApplyFilter.setTitle(applyFilter, for: .normal)
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        
        self.laCollectionFilter.text = self.filterLableName.uppercased()
        
        self.filerLableCall()
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filterLabel.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for:indexPath) as! CategoryTableViewCell
        
        cell.laFilterName.text = self.filterLabel[indexPath.row]
        
        
        cell.tapView.tag = indexPath.row
        
        if selected_array_id.contains((self.filterName?.options![indexPath.row].id)!) {
            cell.selecteedImage.isHidden = false
        }else{
            cell.selecteedImage.isHidden = true
        }
        
        
        //for filert selection
        let tapFilterView = UITapGestureRecognizer(target: self, action: #selector(tapFilterView(sender:)))
        cell.tapView.addGestureRecognizer(tapFilterView)
        cell.tapView.isUserInteractionEnabled = true
        
        return cell
        
        
        
    }
    
    
    
    //======================================================================================
    @objc func tapFilterView(sender: UITapGestureRecognizer) {
        
        let cellTag = sender.view
        
        
        let index  = (cellTag?.tag)!
        
        print(index as Any)
        
        
        if self.selected_array_id.contains((self.filterName?.options![index].id)!){
            if let index = self.selected_array_id.index(of: (self.filterName?.options![index].id)!) {
                self.selected_array_id.remove(at: index)
            }
        }else{
            self.selected_array_id.append((self.filterName?.options![index].id)!)
        }
        
        
        
        
        if self.selected_array_names.contains((self.filterName?.options![index].label)!){
            if let index = self.selected_array_names.index(of: (self.filterName?.options![index].label)!) {
                self.selected_array_names.remove(at: index)
            }
        }else{
            self.selected_array_names.append((self.filterName?.options![index].label)!)
        }
        
        
        
        self.tableView.reloadData()
        
        
        
        
    }
    //======================================================================================
    
    
    @IBAction func buBack(_ sender: Any) {
   
        self.saveData()
        self.navigationController?.popViewController(animated: true)
   
    }
    
   
    @IBAction func tableBack(_ sender: Any) {
        
        
        
        
        
    }
    
    
    
    
    
    
    
    //======================================================================================
    
    @IBAction func buApplyFilter(_ sender: Any) {
        
           self.saveData()
           categoryGlobeldata.applyFilterApi()
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(2) // views to pop
        navigationController?.setViewControllers(viewControllers!, animated: true)

    }
    
    func filerLableCall(){
        
        for i in 0..<(self.filterName?.options?.count)!{
            
            self.filterLabel.append(((self.filterName?.options![i])?.label)!)
        }
        
        if let array = categoryGlobeldata.mySelectedItemsIds[(filterName?.code)!] {
            self.selected_array_id = array 
        }
        
        
        if let array = categoryGlobeldata.mySelectedItemValues[(filterName?.code)!] {
            self.selected_array_names = array 
        }
        
        
    }
    //============================================================
    @objc func tapClearFilter(sender: UITapGestureRecognizer) {
        self.selected_array_id.removeAll()
        self.tableView.reloadData()
        
    }
    
    
    func saveData()  {
        
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
    
    
}
