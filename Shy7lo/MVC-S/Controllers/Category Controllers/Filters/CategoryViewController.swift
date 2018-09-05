//
//  CategoryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/21/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CategoryFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var clearAllFilter: UIView!
    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laFilter: UILabel!
    
    var lang:String!
    var filterName = [String]()
    var categoryResponse:categoryResponse?
    var childData = [categoryDataObj]()
    var haveChild = [String]()
    var selectedIndex = [Int]()
    
    
    
    
    override func viewDidLoad() {
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        self.callCategory()
        //get language from user defaults
        
        self.lang = UserInfoDefault.getLanguage()
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        let applyFilter :String = "ApplyFilter".localizableString(loc: lang)
        self.buttonApplyFilter.setTitle(applyFilter, for: .normal)
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        
        self.laFilter.text = "CategoryCVC".localizableString(loc: lang)
        
        
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
        print(self.childData.count)
        return self.childData.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for:indexPath) as! CategoryTableViewCell
        
        cell.laFilterName.text = self.childData[indexPath.row].name
        let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
        cell.buttonNext.setImage(flippedImage, for: .normal)
        print(indexPath.row)
        
        
        if (self.childData[indexPath.row].children_data?.isEmpty)!{
            cell.buttonNext.isHidden = true
            cell.buttonNext.isUserInteractionEnabled = false
        }else{
        
      
            cell.buttonNext.isHidden = false
            cell.buttonNext.isUserInteractionEnabled = true
        }
        
        if self.selectedIndex.contains(self.childData[indexPath.row].id!){
            
            cell.selecteedImage.isHidden = false
        }else{
            cell.selecteedImage.isHidden = true
        }
        
        cell.buttonNext.tag = indexPath.row
        cell.buttonNext.addTarget(self, action: #selector(CategoryFilterViewController.buttonNextTapped(_:)), for: .touchUpInside)
        cell.tapView.tag = indexPath.row
        
        
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
        _ = IndexPath(row: index , section: 0)


        let currentObject =  self.childData[index]
        if currentObject.children_data?.count == 0{
        
        
        if self.selectedIndex.contains((self.childData[index].id)!){
            if let index = self.selectedIndex.index(of: ((self.childData[index].id)!)) {
                self.selectedIndex.remove(at: index)
            }
        }else{
            
            self.selectedIndex.append((self.childData[index].id)!)
        }
        print(self.selectedIndex)
        
        self.tableView.reloadData()
       
        }
        
        
        
        //        let cell: CategoryTableViewCell = self.tableView.cellForRow(at: cellIndex) as! CategoryTableViewCell
        //
        //        if cell.selecteedImage.isHidden{
        //            cell.selecteedImage.isHidden = false
        //        }
        //        else{
        //            cell.selecteedImage.isHidden = true
        //        }
        
    }
    //======================================================================================
    
    //back button
    @IBAction func buBack(_ sender: Any) {
    
    
        
//         let current = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
//
//         if self.selectedIndex.count > 0{
//
//            categoryGlobeldata.myDictionary[current.id!] =  self.selectedIndex
//
//         }else{
//
//            categoryGlobeldata.myDictionary.removeValue(forKey: current.id!)
//        }
        
        
        
        
        categoryGlobeldata.myArray.removeLast()
        
        let count =  categoryGlobeldata.myArray.count
        if count > 0 {
        
        let a = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
      
            self.childData = a.children_data!
            if let array = categoryGlobeldata.myDictionary[a.id!] {
                self.selectedIndex = array
            }
        
            self.tableView.reloadData()
        }else{
        self.navigationController?.popViewController(animated: true)
        }
    
    
    }
    
    
    
    @IBAction func tableBack(_ sender: Any) {
        
       
        
        
    }
    //========================================================================================
    @objc func buttonNextTapped(_ sender: AnyObject?) {
        
        
        let button = sender as! UIButton
        let buttonIndex = button.tag
        print(buttonIndex)
        
        
      //  categoryGlobeldata.path.append(self.childData[buttonIndex].id!)
        
       
        let current = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
        
        
        if self.selectedIndex.count > 0{
            
            
            categoryGlobeldata.myDictionary[current.id!] =  self.selectedIndex
            
        }else{
            
            categoryGlobeldata.myDictionary.removeValue(forKey: current.id!)
        }
        
        
        
        
        
        self.selectedIndex.removeAll()
        
        
        categoryGlobeldata.myArray.append(self.childData[buttonIndex])
        let next = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
        self.childData = next.children_data!
        if let array = categoryGlobeldata.myDictionary[next.id!] {
            self.selectedIndex = array
        }
        
        
        self.tableView.reloadData()
        

        
    }
    
    
    
    //============================================================
    @objc func tapClearFilter(sender: UITapGestureRecognizer) {
    }
    
    
    //=================================================================
    func callCategory(){
        
        ApisCallingClass.getCategoryFilter { (data) in
            let res : categoryResponse = data!
            self.categoryResponse = res
           // self.childData = (res.data?.children_data)!
            
            
            categoryGlobeldata.myArray.append((res.data)!)
            let a = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
            self.childData = a.children_data!
            
            
            
            
            if let array = categoryGlobeldata.myDictionary[a.id!] {
            
                self.selectedIndex = array
            }
            
            
            
            
            
            
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func buApplyFilter(_ sender: Any) {
        
        // if no selection
        
        
        let count =  categoryGlobeldata.myArray.count
        if count > 0 {
            let a = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
         
            
            if self.selectedIndex.count > 0{
                
                categoryGlobeldata.myDictionary[a.id!] =  self.selectedIndex

            }
            
            
        }
        
        
        
        
        

        
    }
    
}
