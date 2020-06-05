//
//  AdminDishMenuViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 10/1/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreData

extension AdminDishMenuViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier) as? AdminDishMenuTableViewCell else {
            return AdminDishMenuTableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.admindishimage.image = UIImage(data: fetchentreefoods[indexPath.row].fImage as Data)
            cell.admindishname.text = fetchentreefoods[indexPath.row].fName
            cell.admindishcost.text = "$ \(fetchentreefoods[indexPath.row].fPrice)"
        }else if indexPath.section == 1 {
            cell.admindishimage.image = UIImage(data: fetchmainfoods[indexPath.row].fImage as Data)
            cell.admindishname.text = fetchmainfoods[indexPath.row].fName
            cell.admindishcost.text = "$ \(fetchmainfoods[indexPath.row].fPrice)"
        }else {
            cell.admindishimage.image = UIImage(data: fetchdessertfoods[indexPath.row].fImage as Data)
            cell.admindishname.text = fetchdessertfoods[indexPath.row].fName
            cell.admindishcost.text = "$ \(fetchdessertfoods[indexPath.row].fPrice)"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adddishescontroller = storyboard?.instantiateViewController(withIdentifier: "addDishesViewController") as! AddDishesViewController
        
        adddishescontroller.dishitemselect = nil
        
        if indexPath.section == 0 {
            adddishescontroller.dishitemselect = fetchentreefoods[indexPath.row]
            
        }else if indexPath.section == 1 {
            adddishescontroller.dishitemselect = fetchmainfoods[indexPath.row]
            
        }else {
            adddishescontroller.dishitemselect = fetchdessertfoods[indexPath.row]
            
        }
        self.navigationController?.pushViewController(adddishescontroller, animated: true)
    }
    
    //delete item swap
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            admindishtableview.beginUpdates()
            
            
            if indexPath.section == 0 {
                deletefromcoredata(foodobj: fetchentreefoods[indexPath.row])
                fetchentreefoods.remove(at: indexPath.row)
                admindishtableview.deleteRows(at: [indexPath], with: .fade)
                
            }else if indexPath.section == 1 {
                deletefromcoredata(foodobj: fetchmainfoods[indexPath.row])
                fetchmainfoods.remove(at: indexPath.row)
                admindishtableview.deleteRows(at: [indexPath], with: .fade)
                
            }else {
                deletefromcoredata(foodobj: fetchdessertfoods[indexPath.row])
                fetchdessertfoods.remove(at: indexPath.row)
                admindishtableview.deleteRows(at: [indexPath], with: .fade)
                
            }
            
            admindishtableview.endUpdates()
        }
    }
    
    
    
}
class AdminDishMenuViewController: UIViewController {

    @IBOutlet weak var sampleimageview: UIImageView!
    
    @IBOutlet weak var admindishtableview: UITableView!
    
    
    var fetchAllFoodMenu = [FoodItems]()
    var fetchentreefoods = [FoodItems]()
    var fetchmainfoods = [FoodItems]()
    var fetchdessertfoods = [FoodItems]()
    
    
    var cellidentifier = "adminDishMenuTableViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
//        print("View will appear")
        viewDishItems()
        admindishtableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("View did load")
        
//        viewDishItems()
        
        self.admindishtableview.rowHeight = 100;
        
        self.admindishtableview.dataSource = self
        self.admindishtableview.delegate = self
        // Do any additional setup after loading the view.
        
        //set + button on top
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: .add, style: .done, target: self, action: #selector(addButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func addButtonClicked(){
//        print("Ok button clicked")
        //        print(selectArr)
        //move to add new item to dishes
        let adddishescontroller = storyboard?.instantiateViewController(withIdentifier: "addDishesViewController") as! AddDishesViewController
        self.navigationController?.pushViewController(adddishescontroller, animated: true)
        
    }
    
    
    func viewDishItems() {
        //remove all value of array
        fetchAllFoodMenu.removeAll()
        fetchentreefoods.removeAll()
        fetchmainfoods.removeAll()
        fetchdessertfoods.removeAll()
        
        //load coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        //fetchdata coredata
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
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
//        print(fetchAllFoodMenu.count)
    }
    
    func deletefromcoredata( foodobj: FoodItems){
//        print("Delete \(foodobj) from core data")
        
        //coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
    
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let deletefoodname = data.value(forKey: "fName") as! String
                
                if deletefoodname == foodobj.fName {
//                    print("equal value")
                    context.delete(data as! NSManagedObject)
                }
                
            }
        } catch {
                
                print("delete Failed")
            }
       
        do {
            try context.save() // <- remember to put this :)
        } catch {
            print("value deleting fails error")
        }
        
    }
    
}

