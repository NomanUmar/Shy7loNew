//
//  CategoryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/21/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CategoryFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var buDoneOutlet: UIButton!

    @IBOutlet var laclearAllFilter: UILabel!
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
    
    
    
    
    var selected_array_id = [Int]()
   
    
    var Clild_selected_array_names = [String]()

    
    
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
        self.laclearAllFilter.text = "ClearAllFilter".localizableString(loc: lang)
        
        let buDone = "Done".localizableString(loc: lang)
        buDoneOutlet.setTitle(buDone, for: .normal)
        
        
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
        //print(self.childData.count)
       
       
        
        return self.childData.count
        
        
        
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for:indexPath) as! CategoryTableViewCell
        
        cell.laFilterName.text = self.childData[indexPath.row].name
        let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
        cell.buttonNext.setImage(flippedImage, for: .normal)
        print(indexPath.row)
        
        
        
        if (self.childData[indexPath.row].children_data?.isEmpty)!{
            //   no child data

         //   cell.selectedImageRightMargen.constant = 17

            
            cell.buttonNext.isHidden = true
            cell.buttonNext.isUserInteractionEnabled = false
      
            
            if self.selected_array_id.contains(self.childData[indexPath.row].id!){
                
                cell.selecteedImage.isHidden = false
            }else{
                cell.selecteedImage.isHidden = true
            }
            
            cell.selected_Category_lable.text = ""

            
            
        
        }else{
            
            //   if have child data
       //     cell.selectedImageRightMargen.constant = 35

            cell.buttonNext.isHidden = false
            cell.buttonNext.isUserInteractionEnabled = true
      
        
            //  check for id array from global data class
            if categoryGlobeldata.mySelectedCategorryArray.contains(self.childData[indexPath.row].id!){
                cell.selecteedImage.isHidden = false
                cell.buttonNext.isHidden = true
                
            }else{
                cell.selecteedImage.isHidden = true
                cell.buttonNext.isHidden = false

            }
            
            
//            if let child_nameArray = categoryGlobeldata.mySelectedCategoryNamesDic_refByParent[self.childData[indexPath.row].id!] {
//
//                var text  = ""
//                for (i, name) in child_nameArray.enumerated() {
//                    if i == 0{
//                        text = name
//                    }else{
//                        text = text + "," + name
//                    }
//                }
//                cell.selected_Category_lable.text = text
//
//            }else{
//                cell.selected_Category_lable.text = ""
//            }
            
     //----------------------------------------------
//            var text  = ""
//            for (i, obj) in categoryGlobeldata.mySelected_category_ObjectsArray.enumerated() {
//
//
//                if obj.parent_id == self.childData[indexPath.row].id{
//                    if i == 0{
//                        text = obj.name!
//                    }else{
//                        text = text + "," + obj.name!
//                    }
//                }
//
//            }
//            cell.selected_Category_lable.text = text
//
        
            
            var text  = ""
            for (name, patentArray) in categoryGlobeldata.mySelectedCategoryDic_Path {
                for parent in patentArray {
                    if parent.id == self.childData[indexPath.row].id {
                        if text == ""{
                            text = name
                        }else{
                        text = text + "," + name
                        }
                    }
                } // iner for
            } // for loop
            cell.selected_Category_lable.text = text
            
            
            
            
            
        } // child data is empty
            

        
        
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
        
       // this is table view cell click event
        
        let cellTag = sender.view
        let index  = (cellTag?.tag)!
        print(index as Any)
        _ = IndexPath(row: index , section: 0)

        let currentObject =  self.childData[index]
        if currentObject.children_data?.count == 0{
        
        if self.selected_array_id.contains((self.childData[index].id)!){
            if let index = self.selected_array_id.index(of: ((self.childData[index].id)!)) {
                self.selected_array_id.remove(at: index)
                
            }
        }else{
            self.selected_array_id.append((self.childData[index].id)!)
            
           }
        
       
        }else{
           
            
            // id have childs but selected as a whole
            if categoryGlobeldata.mySelectedCategorryArray.contains(currentObject.id!){
                if let itemToRemoveIndex = categoryGlobeldata.mySelectedCategorryArray.index(of: currentObject.id!) {
                    categoryGlobeldata.mySelectedCategorryArray.remove(at: itemToRemoveIndex)
                }
            }else{
                categoryGlobeldata.mySelectedCategorryArray.append(currentObject.id!)
            }
        
    }
        
        
        
        
        
//        var found = false
//        for (i, obj) in categoryGlobeldata.mySelected_category_ObjectsArray.enumerated() {
//            if obj.id == currentObject.id{
//                found = true
//                categoryGlobeldata.mySelected_category_ObjectsArray.remove(at: i)
//                print("--?found true remove")
//            }
//        }
//        if found == false {
//            categoryGlobeldata.mySelected_category_ObjectsArray.append(self.childData[index])
//            print("--?found false add")
//        }
//
        
        
        
        
        if let array = categoryGlobeldata.mySelectedCategoryDic_Path[currentObject.name!] {
            print("--?found true remove")

           categoryGlobeldata.mySelectedCategoryDic_Path.removeValue(forKey: currentObject.name!)
        }else{
            categoryGlobeldata.mySelectedCategoryDic_Path[currentObject.name!] =  categoryGlobeldata.myArray
            print("--?found false add")

        }
        
        
        
   
        
        self.tableView.reloadData()

        
        
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
    
        
        
        self.saveData()
        
        categoryGlobeldata.myArray.removeLast()
        
        let count =  categoryGlobeldata.myArray.count
        if count > 0 {
        
        let a = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
            self.childData = a.children_data!
           
            if let array = categoryGlobeldata.mySelectedCategoryDic_refByParent[a.id!] {
                self.selected_array_id = array
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
        
       
        
        self.saveData()
        
        
        
        self.selected_array_id.removeAll()
     

        
        categoryGlobeldata.myArray.append(self.childData[buttonIndex])
        let next = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]
        self.childData = next.children_data!
       
        if let array = categoryGlobeldata.mySelectedCategoryDic_refByParent[next.id!] {
            self.selected_array_id = array
        }
        
        
        
        self.tableView.reloadData()
        

        
    }
    
    
    
    //============================================================
    @objc func tapClearFilter(sender: UITapGestureRecognizer) {
 
        
        let current = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]

        categoryGlobeldata.mySelectedCategoryDic_refByParent.removeValue(forKey: current.id!)

        self.selected_array_id.removeAll()
        
        
    //    self.childData[indexPath.row]
        
        
        for childData in self.childData {
        
            if categoryGlobeldata.mySelectedCategorryArray.contains(childData.id!){
                
                //  print("--?\(categoryGlobeldata.mySelectedCategorryArray)")
                if let itemToRemoveIndex = categoryGlobeldata.mySelectedCategorryArray.index(of: childData.id!) {
                    categoryGlobeldata.mySelectedCategorryArray.remove(at: itemToRemoveIndex)
              
                    if let array = categoryGlobeldata.mySelectedCategoryDic_Path[childData.name!] {
                        print("--?found true remove")
                        
                        categoryGlobeldata.mySelectedCategoryDic_Path.removeValue(forKey: childData.name!)
                        
                    }
                
                }
            }
            
        
        
        }
        
        
        
        
        
        
        saveData()
    
        
        
        self.tableView.reloadData()
        
    
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
            
            
            
            
            if let array = categoryGlobeldata.mySelectedCategoryDic_refByParent[a.id!] {
            
                self.selected_array_id = array
            }
            
          
            
            
            
            
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func buApplyFilter(_ sender: Any) {
        
        self.saveData()
        categoryGlobeldata.applyFilterApi()
        
        
        
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(2) // views to pop
        navigationController?.setViewControllers(viewControllers!, animated: true)

    }
    
    
    
    func saveData() {
        
        let current = categoryGlobeldata.myArray[categoryGlobeldata.myArray.count - 1]

        if self.selected_array_id.count > 0{
            categoryGlobeldata.mySelectedCategoryDic_refByParent[current.id!] =  self.selected_array_id
        }else{
            categoryGlobeldata.mySelectedCategoryDic_refByParent.removeValue(forKey: current.id!)
        }
    
        
        
        
        
    }  // save Data function
    
    
    @IBAction func buDoneAction(_ sender: Any) {
        
        self.saveData()
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    
    
}
