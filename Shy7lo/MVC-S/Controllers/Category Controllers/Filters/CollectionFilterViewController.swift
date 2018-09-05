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
    
    var selectedIndex = [String]()
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
        
        if selectedIndex.contains((self.filterName?.options![indexPath.row].id)!) {
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
        
        
        if self.selectedIndex.contains((self.filterName?.options![index].id)!){
            if let index = self.selectedIndex.index(of: (self.filterName?.options![index].id)!) {
                self.selectedIndex.remove(at: index)
            }
        }else{
            self.selectedIndex.append((self.filterName?.options![index].id)!)
        }
        print(self.selectedIndex)
        
        self.tableView.reloadData()
        
        
        
        //        let cellIndex = IndexPath(row: index , section: 0)
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
    
    
    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func tableBack(_ sender: Any) {
        
        
        
        
        
    }
    
    
    
    
    
    
    
    //======================================================================================
    
    @IBAction func buApplyFilter(_ sender: Any) {
        
        print(self.selectedIndex)
        
    }
    
    func filerLableCall(){
        
        for i in 0..<(self.filterName?.options?.count)!{
            
            self.filterLabel.append(((self.filterName?.options![i])?.label)!)
        }
    }
    //============================================================
    @objc func tapClearFilter(sender: UITapGestureRecognizer) {
        self.selectedIndex.removeAll()
        self.tableView.reloadData()
        
    }
}
