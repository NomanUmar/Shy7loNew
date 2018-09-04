//
//  ProductViewController.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/14/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import UIKit
import DropDown
import Kingfisher

class ProductViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var brandView: UIView!
    @IBOutlet var TFNewest: UITextField!
    @IBOutlet var laFilter: UILabel!
    @IBOutlet var filterView: UIView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    //@IBOutlet var dropDownTF: UITextField!
    @IBOutlet var laProductName: UILabel!
    
    var isLoading:Bool!
    var indecator:UIView? = nil
    var subCategoryName:String!
    var subCategoryId:String!
    let dropDown = DropDown()
    var productRespone:ProductResponse!
    var productList = [product_listing]()
    var lang:String!
    var ExchangeRate = [ExchangeRateObj]()
    var currancy:String!
    var currencyChangeRate : Float!
    override func viewDidLoad() {
        
        
        
        
        //set image in same direction with language
        let flippedImage = UIImage(named: "back_icon")?.imageFlippedForRightToLeftLayoutDirection()
        
        self.buttonBack.setImage(flippedImage, for: .normal)
        
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        //dropDownTF.delegate = self
        
        //get language from user defaults
        
        self.lang = UserInfoDefault.getLanguage()
        
        // courrancy get from userfault
        
        self.laFilter.text =  "Filter".localizableString(loc: self.lang)
        self.TFNewest.text = "Newest".localizableString(loc: self.lang)
        
        if lang.contains("ar"){
            self.currancy = UserInfoDefault.getCurrancyArabic()
        }else{
            self.currancy = UserInfoDefault.getCurrancyEnglish()
        }
        
        
        
        // self.dropDownLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.indecator = UIViewController.displaySpinner(onView: self.view)
        self.ProductById(id: subCategoryId , page : 1)
        print(subCategoryId)
       
        self.currencyCall()
        
        
        self.laProductName.text = self.subCategoryName.uppercased()
        
        //for filert selection
        let tapFilterView = UITapGestureRecognizer(target: self, action: #selector(tapFilterView(sender:)))
        filterView.addGestureRecognizer(tapFilterView)
        filterView.isUserInteractionEnabled = true
        
        //for brand selection
        let tapBrandView = UITapGestureRecognizer(target: self, action: #selector(tapBrandView(sender:)))
        brandView.addGestureRecognizer(tapBrandView)
        brandView.isUserInteractionEnabled = true
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //--------------------------------------------------------------------------------
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.productList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // let currentImage = self.images[indexPath.row] as ImageObj
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let postPicUrl =  URL(string: self.productList[indexPath.row].image!)!
        print(postPicUrl)
        //imagePlaceHolder
    
        cell.productImage.kf.setImage(with: postPicUrl, placeholder: UIImage(named: "imagePlaceHolder"), options: nil, progressBlock: nil) { (image, error, cacheType, postPicUrl ) in
            
            
            
            
            
            //device width
            
            let bounds = UIScreen.main.bounds
            let newImageWidth = (bounds.size.width / 2) - 12
            let urlImageWidth = (image?.size.width)!
            let urlImageHeigth = (image?.size.height)!
            
            
             let newImageHight = ((urlImageHeigth / urlImageWidth) * newImageWidth)
          
            
            //let size = CGSize(width: newImageWidth , height: newImageHight)
            
            
            print("old width ---> \(urlImageWidth)")
            print("old height ---> \(urlImageHeigth)")
            print("new width ---> \(newImageWidth)")
            print("new height ---> \(newImageHight)")
            
            
            
            
            //image.frame = CGRect(x: 0, y: 0, width: 50, height: screenSize.height * 0.2)
            
           
            
            
          /*  DispatchQueue.main.async {
                
                // cell.productImage.frame.size.width =  newImageWidth
                
                if Int((image?.size.width)!) > Int((image?.size.height)!) {
                    cell.productImage.contentMode = .scaleAspectFit
                    
                    //since the width > height we may fit it and we'll have bands on top/bottom
                } else {
                    
                    
                    cell.productImage.contentMode =  .redraw
                    
                    cell.productImage.layer.masksToBounds = true
                    
                    //width < height we fill it until width is taken up and clipped on top/bottom
                }
                 
                
            }*/
                //self.ResizeImage(image: image!, targetSize: size)
            
        
        
            
         /*   if Int((image?.size.width)!) > Int((image?.size.height)!) {
                cell.productImage.contentMode = .scaleAspectFit
            
                //since the width > height we may fit it and we'll have bands on top/bottom
            } else {
                
              
                cell.productImage.contentMode =  .scaleAspectFill
                
                cell.productImage.layer.masksToBounds = true
                
                //width < height we fill it until width is taken up and clipped on top/bottom
            }*/
            
            
         
          
        }
        
       
        //=========================================================================
        
        let specialFromDate =  self.productList[indexPath.row].special_from_date
        let specialT0Date =  self.productList[indexPath.row].special_from_date
        
        let dateFormatter = DateFormatter()
        dateFormatter.date(from:specialFromDate!)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFrom = dateFormatter.date(from: specialFromDate!)
        dateFormatter.dateStyle = .medium
        let finalFromDate = dateFormatter.string(from: dateFrom!)
        
        dateFormatter.date(from:specialFromDate!)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let toDate = dateFormatter.date(from: specialT0Date!)
        dateFormatter.dateStyle = .medium
        let finaltoDate = dateFormatter.string(from: toDate!)
        
        
        //====================================================================
        
        
        
        
        let specialPrice = self.productList[indexPath.row].special_price!
        
        
        if finalFromDate <= finaltoDate {
            
            if specialPrice != 0{
                
                let specialRate = Float(self.productList[indexPath.row].special_price!) * self.currencyChangeRate
                // round off up to 2 decimal
                let roundSpecialRate = String(format: "%.1f", specialRate)
                // result = 3.3
                if lang.contains("ar"){
                cell.laSpecialPrice.text =  String( roundSpecialRate) + " " + self.currancy
               
                }else{
                    
                cell.laSpecialPrice.text = self.currancy + " " + String( roundSpecialRate)
               

                    
                }
                cell.textCutView.isHidden = false
                print( "Hight-->\(cell.laSpecialPrice.frame.height)")
            }else{
                cell.laSpecialPrice.text = ""
                cell.textCutView.isHidden = true
            }
        }else{
            cell.laSpecialPrice.text = ""
            cell.textCutView.isHidden = true
            
        }
        
        
        
        let priceRate = Float(self.productList[indexPath.row].price!) * self.currencyChangeRate
        
        // round off up to 2 decimal
        let roundPriceRate = String(format: "%.1f", priceRate)
        
        if lang.contains("ar"){
              cell.laprice.text =  String(roundPriceRate)  + " " + self.currancy
        }else{
             cell.laprice.text = self.currancy + " " + String(roundPriceRate)
        }
      
        
        
        //==================================================================
        // marge the brand and name and also change color of brand
        
        
        var str1 = self.productList[indexPath.row].brand
        var str2 = self.productList[indexPath.row].name
        
        if str1 == nil{
            
            str1 = ""
        }
        
        if str2 == nil{
            
            str2 = ""
        }
      
        
        let finalStr = str1! + " " + str2!
    
        let color = UIColor(red:0.52, green:0.52, blue:0.52, alpha:1.0)
        let string: NSMutableAttributedString = NSMutableAttributedString(string: finalStr)
        string.setColorForText(textToFind: str1!, withColor: UIColor.black)
        string.setColorForText(textToFind: str2!, withColor: color)
        
        cell.laDiscription.attributedText = string
        
        
        print( "Hight-->\(cell.laDiscription.frame.height)")
        
        
        //====================================================================
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.collectionView.bounds.width/2.0
        // let cellHight = cellWidth * 1.75
    
       
        let  discription = 17 + 17
        
        
        
        let value = 10 + 6 + 15
        let newHight = ((239 / 181) * cellWidth) + CGFloat(value + discription)
        print("new Hight-->\(newHight)")
        print("cell width-->\(cellWidth)")
        return CGSize(width: cellWidth - 12, height: newHight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        return UIEdgeInsetsMake(0.0, 8.0, 0.0, 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("\n \n load more willDisplay \n \n \(indexPath)")
        
        
        if indexPath.row ==  self.productList.count  - 4 {
            
            let totalCount = self.productRespone.data?.total_count!
            let pageLimit = Int((self.productRespone.data?.request_params.limit!)!)
            let page = Int((self.productRespone.data?.request_params.page!)!)
            print("Intex----->\(indexPath.row) ---> \(String(describing: totalCount))")
            print(pageLimit! * page! )
            print(totalCount!)
            if  pageLimit! * page! <= totalCount!{
                
                
                if   self.isLoading == false
                {
                    self.ProductById(id: self.subCategoryId, page: page! + 1)
                    
                }else{
                    
                    print(" \n \n Wait load more willDisplay \n \n \(indexPath)")
                }
            }else{
                
            }
        }
    }
    
    //--------------------------------------------------------------------------------
    //==========================================================================
    //call api by ID for product
    func ProductById(id:String , page: Int){
        //category_id=143&sort_by=created_at&direction=DESC&filter[brand]=289&page=1
        
        
        self.isLoading = true
        
        
        
        ApisCallingClass.getProductdID(id: id, sort_by: "saving", direction: "DESC", page: page) { (data) in
            
            if data != nil {
                UIViewController.removeSpinner(spinner: self.indecator!)
                self.productRespone = data
                print(data!)
                self.productList = self.productList +  (self.productRespone.data?.product_listing)!
                
                self.isLoading = false
                
                self.collectionView.reloadData()
                
                
              
            }
            
        }
        
    }
    //===============================================================================
    //for make dropdown
    
    
    func dropDownLoad(){
        // The view to which the drop down will appear on
        // dropDown.anchorView = self.dropDownTF // UIView or UIBarButtonItem
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: ((dropDown.anchorView?.plainView.bounds.width)! - 200), y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.backgroundColor = UIColor.white
        //dropDown.textColor = UIColor.white
        dropDown.cornerRadius = 10
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["الرياض", "جدة", "الدمام","المدينة","مكة","الطائف","القصيم","الجبيل","حائل","عرعر","نجران","جازان","تبوك","الجوف","الباحة","الأحساء","أبها","ينبع","حفر الباطن","عسير"]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            // self.dropDownTF.text = item
        }
        
        // Will set a custom width instead of the anchor view width
        dropDown.width = 200
        //dropDown.show()
        dropDown.hide()
        
    }
    //=================================================================================
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            dropDown.show()
            return false
        }
        else
        {
            dropDown.hide()
            return true
        }
    }
    //=================================================================================
    func currencyCall(){
        
        let data = UserDefaults.standard.value(forKey:"AppInit") as? Data
        let jsonDecoder = JSONDecoder()
        if let res = try? jsonDecoder.decode ( AppInitResponse.self , from: data!  ) as   AppInitResponse {
            
            self.ExchangeRate = res.currencies.exchange_rates
            
            print(self.ExchangeRate[1].rate)
        }
        
        let getCurr = UserInfoDefault.getCurrancyEnglish()
        for i in 0..<self.ExchangeRate.count{
            
            if getCurr == self.ExchangeRate[i].currency_to{
                print("ExchangeRate-->\(self.ExchangeRate[i].rate)")
                self.currencyChangeRate = self.ExchangeRate[i].rate
                
            }
        }
        
    }
    //=================================================================================
    
    @objc func tapFilterView(sender: UITapGestureRecognizer) {
      
        //start ignoring intrection
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FiltersViewController") as! FiltersViewController
        vc.categoryId = self.subCategoryId
        print(vc.categoryId)
       
        //end ignoring intrection
        
        UIApplication.shared.endIgnoringInteractionEvents()
        self.navigationController?.pushViewController(vc,animated: true)
       
        
        
        
    }
    
    @objc func tapBrandView(sender: UITapGestureRecognizer) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "NewestViewController") as! NewestViewController
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    //=======================================================================================
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    
    func imageWithImage (sourceImage:UIImage, scaledToWidth: CGFloat) -> UIImage {
        let oldWidth = sourceImage.size.width
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = sourceImage.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}
//===========
extension UIImage{
    
    func getRatio()->CGFloat{
        let widthRatio =  CGFloat(self.size.width/self.size.height)
        return widthRatio
        
    }
}



