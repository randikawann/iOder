//
//  AddOrderViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/27/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class AddOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    
    @IBOutlet weak var memberOfTable: UITextField!
    @IBOutlet weak var addStaffIdPicker: UIPickerView!
    
    var pickerData = [String]()
    
    //pickerview Setup
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
        print("choose waiter : \(pickerData[row])")
//        waiterID = pickerData[row]
        currentOrderDetails.starfId = pickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // current order details should be nil at the start
        
        
        
        // Do any additional setup after loading the view.
        self.title = "Add Order"
        pickerData = ["Waiter01", "Waiter02", "waiter03", "Waiter04"]
        
        self.addStaffIdPicker.dataSource = self
        self.addStaffIdPicker.delegate = self
        
        //set default waiter id value
        currentOrderDetails.starfId = pickerData[0]
    }
    
    @IBAction func startOrder(_ sender: Any) {
//        memberOfTablevalue = memberOfTable.text ?? ""
        currentOrderDetails.memberOfTable = memberOfTable?.text ?? ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}
