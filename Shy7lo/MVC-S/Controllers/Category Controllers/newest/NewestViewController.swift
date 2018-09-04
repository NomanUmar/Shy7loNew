//
//  NewestViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 9/3/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit

class NewestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var lang:String!
    var filterName =  ["most_viewed","created_at","price with direction - DESC","price with direction - ASC","saving"]
    
    
    override func viewDidLoad() {
        
         self.lang = UserInfoDefault.getLanguage()
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        //awake XIB
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        super.viewDidLoad()
        
        
        //table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=============================================================================
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
        
        
//        var frame = self.tableView.frame
//        frame.size.height = self.tableView.contentSize.height
//        self.tableView.frame = frame
        
        
        return cell
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    //======================================================================================
    @objc func tapFilterView(sender: UITapGestureRecognizer) {
        
        let cellTag = sender.view
        
        
        let index  = (cellTag?.tag)!
        print(index as Any)
        
        let cellIndex = IndexPath(row: index , section: 0)
        
        let cell: CategoryTableViewCell = self.tableView.cellForRow(at: cellIndex) as! CategoryTableViewCell
        
      
            cell.selecteedImage.isHidden = false
        
    
        self.dismiss(animated: true, completion: nil)
        
        
        
    }

}
