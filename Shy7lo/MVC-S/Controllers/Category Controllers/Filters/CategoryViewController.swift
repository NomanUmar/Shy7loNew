//
//  CategoryViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/21/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class CategoryFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laFilter: UILabel!
    
    var lang:String!
    var filterName = [String]()
    var categoryResponse:categoryResponse?
    var childData:[children_data_Obj]?
    
    
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
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filterName.count
        
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
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for:indexPath) as! CategoryTableViewCell
            
        cell.laFilterName.text = self.filterName[indexPath.row - 1]
            let flippedImage = UIImage(named: "next_icon")?.imageFlippedForRightToLeftLayoutDirection()
            cell.buttonNext.setImage(flippedImage, for: .normal)
            
            if (self.categoryResponse?.data?.children_data![indexPath.row].children_data?.isEmpty)!{
                cell.buttonNext.isHidden = true
                cell.buttonNext.isUserInteractionEnabled = false
             
                
            }else{
                cell.buttonNext.isHidden = false
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
        
    }
    
    
    
    //======================================================================================
    @objc func tapFilterView(sender: UITapGestureRecognizer) {
        
        let cellTag = sender.view
        
        
        let index  = (cellTag?.tag)!
        print(index as Any)
        
        let cellIndex = IndexPath(row: index , section: 0)
        
        if index == 0
        {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        else {
            
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
        self.navigationController?.popViewController(animated: true)
    }

    func callCategory(){
        
        ApisCallingClass.getCategoryFilter { (data) in
            let res : categoryResponse = data!
            self.categoryResponse = res
            self.childData = res.data?.children_data
            for i in 0..<(res.data?.children_data?.count)!{
                self.filterName.append((res.data?.children_data![i].name)!)
            }
            
            self.tableView.reloadData()
        }
    }
    
    //========================================================================================
    @objc func buttonNextTapped(_ sender: AnyObject?) {
        
        
        let button = sender as! UIButton
        let buttonIndex = button.tag
        print(buttonIndex)
        
        
        
    
      
    }

}
