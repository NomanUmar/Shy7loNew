//
//  SizeViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/21/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class SizeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet var buttonApplyFilter: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var laSizeFilter: UILabel!
    
    var lang:String!
    var filterName = ["XS","S","M","L","XL","XXL","XXXL","UK2","UK4"]

    override func viewDidLoad() {
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        //get language from user defaults
        
        self.lang = UserInfoDefault.getLanguage()
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        let applyFilter :String = "ApplyFilter".localizableString(loc: lang)
        self.buttonApplyFilter.setTitle(applyFilter, for: .normal)
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        
        self.laSizeFilter.text = "Size".localizableString(loc: lang)
        
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        //awake XIB
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
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
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for:indexPath) as! CategoryTableViewCell
        
        cell.laFilterName.text = self.filterName[indexPath.row].localizableString(loc: self.lang)
        
        
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
       
        let cellIndex = IndexPath(row: index , section: 0)
        
        let cell: CategoryTableViewCell = self.tableView.cellForRow(at: cellIndex) as! CategoryTableViewCell
        
        if cell.selecteedImage.isHidden{
            cell.selecteedImage.isHidden = false
        }
        else{
            cell.selecteedImage.isHidden = true
        }
        
        
        
    }
    //======================================================================================
    
    //back button
    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
