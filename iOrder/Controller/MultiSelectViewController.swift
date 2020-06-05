//
//  MultiSelectViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/26/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreData

class MultiSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fetchAllFoodMenu = [FoodItems]()
    var fetchentreefoods = [FoodItems]()
    var fetchmainfoods = [FoodItems]()
    var fetchdessertfoods = [FoodItems]()
    
 
    
    @IBOutlet weak var multipleViewSelectTabelView: UITableView!
    
  //header section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = "Entree"
        }
        if section == 1 {
            label.text = "Main"
        }
        if section == 2 {
            label.text = "Dessert"
        }
        
        label.backgroundColor = UIColor.lightGray
        return label
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //content
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fetchentreefoods.count
        }
        else if section == 1 {
            return fetchmainfoods.count
        }
        else{
           return fetchdessertfoods.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //get make row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "multiplerowtablecell") as? MultipleRowTableViewCell else {
            return MultipleRowTableViewCell()
        }
        
       
        
        if indexPath.section == 0 {
            cell.mealimages.image = UIImage(data: fetchentreefoods[indexPath.row].fImage as Data)
            cell.mealName.text = fetchentreefoods[indexPath.row].fName
            cell.mealPrice.text = "$ \(fetchentreefoods[indexPath.row].fPrice)"
        }else if indexPath.section == 1 {
            cell.mealimages.image = UIImage(data: fetchmainfoods[indexPath.row].fImage as Data)
            cell.mealName.text = fetchmainfoods[indexPath.row].fName
            cell.mealPrice.text = "$ \(fetchmainfoods[indexPath.row].fPrice)"
        }else {
            cell.mealimages.image = UIImage(data: fetchdessertfoods[indexPath.row].fImage as Data)
            cell.mealName.text = fetchdessertfoods[indexPath.row].fName
            cell.mealPrice.text = "$ \(fetchdessertfoods[indexPath.row].fPrice)"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indextPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indextPath: indexPath)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.title = "Select Order"
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(okButtonClicked))
        // Do any additional setup after loading the view.
        
        viewDishItems()
        
        self.multipleViewSelectTabelView.rowHeight = 100;
        self.multipleViewSelectTabelView.isEditing = true
        self.multipleViewSelectTabelView.allowsMultipleSelectionDuringEditing = true
        
        
        multipleViewSelectTabelView.dataSource = self
        multipleViewSelectTabelView.delegate = self
        
        
        
    }
    
    //Select deselect Table view cell
    func selectDeselectCell(tableView: UITableView, indextPath: IndexPath){
        fetchselectedarray.removeAll()
        
        if let arr = tableView.indexPathsForSelectedRows{
//            print(arr)
            var totalCost: Float = 0
            for index in  arr{
                if index.section == 0 {
//                    fetchselectedarray.append(fetchentreefoods[index.row])
                    fetchselectedarray.append(FoodItemsNotImg(fCategory: fetchentreefoods[index.row].fCategory, fName: fetchentreefoods[index.row].fName, fPrice:
                        fetchentreefoods[index.row].fPrice))
                    
                    totalCost += fetchentreefoods[index.row].fPrice
                } else if index.section == 1 {
//                    fetchselectedarray.append(fetchmainfoods[index.row])
                    fetchselectedarray.append(FoodItemsNotImg(fCategory: fetchmainfoods[index.row].fCategory, fName:
                        fetchmainfoods[index.row].fName, fPrice:
                        fetchmainfoods[index.row].fPrice))
                    
                    totalCost += fetchmainfoods[index.row].fPrice
                }else {
//                    fetchselectedarray.append(fetchdessertfoods[index.row])
                    fetchselectedarray.append(FoodItemsNotImg(fCategory: fetchdessertfoods[index.row].fCategory, fName: fetchdessertfoods[index.row].fName, fPrice: fetchdessertfoods[index.row].fPrice))
                    
                    totalCost += fetchdessertfoods[index.row].fPrice
                }
                
            }
            currentOrderDetails.orderItems = fetchselectedarray.count as NSObject
            currentOrderDetails.totalCost = totalCost
        }
        
    }

    @objc func okButtonClicked(){
        
        if !fetchselectedarray.isEmpty {
            let okbuttonClicked = storyboard?.instantiateViewController(withIdentifier: "foodOrderViewController") as! FoodOrderViewController
            self.navigationController?.pushViewController(okbuttonClicked, animated: true)
        }else{
            let alertController = UIAlertController(title: "Ooops... !", message: "Select at least one item...", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
          
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
//            print("validation error")
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func viewDishItems() {
        //load coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        //fetchdata coredata
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
//                print(data)
                let selectfodcategory = data.value(forKey: "fCategory") as! String
                //                print("Order details \(orderdetails)")
                
                fetchAllFoodMenu.append(FoodItems(fCategory: data.value(forKey: "fCategory") as! String, fImage: data.value(forKey: "fImage") as! NSData, fName: data.value(forKey: "fName") as! String, fPrice: data.value(forKey: "fPrice") as! Float))
                
                if(selectfodcategory == "Entree"){
                    fetchentreefoods.append(FoodItems(fCategory: data.value(forKey: "fCategory") as! String, fImage: data.value(forKey: "fImage") as! NSData, fName: data.value(forKey: "fName") as! String, fPrice: data.value(forKey: "fPrice") as! Float))
                }else if(selectfodcategory == "Main"){
                    fetchmainfoods.append(FoodItems(fCategory: data.value(forKey: "fCategory") as! String, fImage: data.value(forKey: "fImage") as! NSData, fName: data.value(forKey: "fName") as! String, fPrice: data.value(forKey: "fPrice") as! Float))
                }else { //dessert
                    fetchdessertfoods.append(FoodItems(fCategory: data.value(forKey: "fCategory") as! String, fImage: data.value(forKey: "fImage") as! NSData, fName: data.value(forKey: "fName") as! String, fPrice: data.value(forKey: "fPrice") as! Float))
                }
                
                
            }
        }catch {
            
            print("Failed")
        }
        
    }
    
    
}

