//
//  AdminOrderViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/30/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreData

extension AdminOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tabel view \(orderdetailsSet.count)")
        return orderdetailsSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get make row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier) as? StarfOrderTableViewCell else {
            return StarfOrderTableViewCell()
        }
        
        cell.orderTime.text = "\(orderdetailsSet[indexPath.row].orderTime!)"
        cell.starfId.text = "\(orderdetailsSet[indexPath.row].starfId ?? "")"
        cell.orderTatalCost.text = "$ \(orderdetailsSet[indexPath.row].totalCost)"
        
        
        
        print("cell value \(cell)")
        return cell
    }
    
    
}
extension AdminOrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickStarfName = pickerData[row]
        viewOrder()
        
        
    }

    
}

class AdminOrderViewController: UIViewController {

    @IBOutlet weak var starfSelectPicker: UIPickerView!
    
    @IBOutlet weak var starfSelectTableView: UITableView!
    
    var pickerData = [String]()
    var pickStarfName: String!
    var cellidentifier = "starfOrderTableViewCell"
    
    var orderdetailsSet = [OrderDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.starfSelectPicker.dataSource = self
        self.starfSelectPicker.delegate = self
        
        starfSelectTableView.dataSource = self
        starfSelectTableView.delegate = self
        self.starfSelectTableView.rowHeight = 80;
        
        self.title = "Admin Order"
        
        pickerData = ["All", "Waiter01", "Waiter02", "waiter03", "Waiter04"]
        
        // view table view value start view controller
        pickStarfName = "All"
        viewOrder()
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func viewOrder(){
        
        //load coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        //fetchdata coredata
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        
        do {
            let result = try context.fetch(request)
            orderdetailsSet.removeAll()
            for data in result as! [NSManagedObject] {
                
                let orderdetails = data.value(forKey: "starfId") as! String
                
//                let orderdetailsdate = data.value(forKey: "orderTime") as! NSDate
//                print(orderdetailsdate)
                
//                print(orderdetails)
                
//
                if orderdetails == pickStarfName {
                    
                    
                    orderdetailsSet.append(OrderDetails(orderTime: data.value(forKey: "orderTime") as! NSDate, starfId: data.value(forKey: "starfId") as! String, orderItems: data.value(forKey: "orderItems") as! NSObject, totalCost: data.value(forKey: "totalCost") as! Float, memberOfTable: "\(data.value(forKey: "memberOfTable"))" as! String))
                    
                    
                    
                }else if pickStarfName == "All" {
                    orderdetailsSet.append(OrderDetails(orderTime: data.value(forKey: "orderTime") as! NSDate, starfId: data.value(forKey: "starfId") as! String, orderItems: data.value(forKey: "orderItems") as! NSObject, totalCost: data.value(forKey: "totalCost") as! Float, memberOfTable: "\(data.value(forKey: "memberOfTable"))" as! String))
                    
                    
                    
                }
                
         
            }
            
        } catch {
            
            print("Failed")
        }
        print("Prder detail set \(orderdetailsSet.count)")
        starfSelectTableView.reloadData()
        
    }
}
