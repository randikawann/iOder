//
//  FoodOrderViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/26/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

extension FoodOrderViewController: MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result.rawValue{
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            controller.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            controller.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            controller.dismiss(animated: true, completion: nil)
        default:
            controller.dismiss(animated: true, completion: nil)
            break
            
        }
    }
    
    
}
extension FoodOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchselectedarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get make row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify) as? SelectOrderTableViewCell else {
            return SelectOrderTableViewCell()
        }
        
        cell.orderMealName.text = fetchselectedarray[indexPath.row].fName
        cell.orderMealPrice.text = "$ \(fetchselectedarray[indexPath.row].fPrice)"
        
        return cell
    }
    
    
}

class FoodOrderViewController: UIViewController {

    var entreemeal = [String]()
    var cellIdentify = "selectorderrowtablecell"
    
    
    @IBOutlet weak var selectdOrder: UITableView!
    
    @IBOutlet weak var starfIdLabel: UILabel!
    @IBOutlet weak var customeroftablelabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Confirm Order"

        //set value for labels
        starfIdLabel.text = currentOrderDetails.starfId
        customeroftablelabel.text = currentOrderDetails.memberOfTable
        totalCostLabel.text = "$ \(currentOrderDetails.totalCost)"
//        print(currentOrderDetails.totalCost)
        
        
        selectdOrder.delegate = self
        selectdOrder.dataSource = self

    
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getcurrentDateNtime(){
        
        let date = Date()
        currentOrderDetails.orderTime = date as NSDate
    }
    
    func saveEmployDetailsCoredata(){
        //coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Order", in: context)
        
        let setOrder = NSManagedObject(entity: entity!, insertInto: context)
        
        setOrder.setValue(Int16(currentOrderDetails.memberOfTable), forKey: "memberOfTable")
        setOrder.setValue(currentOrderDetails.orderItems, forKey: "orderItems")
        setOrder.setValue(currentOrderDetails.orderTime, forKey: "orderTime")
        setOrder.setValue(currentOrderDetails.starfId, forKey: "starfId")
        setOrder.setValue(currentOrderDetails.totalCost as! Float, forKey: "totalCost")
        
//        print(setOrder)
        do {
            try context.save()
            
        } catch {
            print("Failed saving")
        }
        
        
    }
    
    func sendMessageConfirmOrder(){
        let messageBody = "Order time: \(currentOrderDetails.orderTime), Staff Id: \(currentOrderDetails.starfId), total Cost: \(currentOrderDetails.totalCost), Order item: \(fetchselectedarray)"
//        print(messageBody)
        let chefPhonenumber: String = "+9471433243"
        let cashirPhonenumber: String = "+9471433243"
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = messageBody
            controller.recipients = [chefPhonenumber, cashirPhonenumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }else{
            
        }
    }
    
    func showAlart(){
        let alertController = UIAlertController(title: "Successfull... !", message: "Your Order Placed success. Thank you..", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            //                print("Ok button tapped");
           self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        //back to root menu
    }
    //Button Clicked
    @IBAction func confirmBtnClicked(_ sender: Any) {
        //get order time and date
        getcurrentDateNtime()
        
        //save core data
        saveEmployDetailsCoredata()
        
        //Send SMS.....
        sendMessageConfirmOrder()
        //Order confirm button
        
        showAlart()
        
        
        
        
        
    }

    

}
