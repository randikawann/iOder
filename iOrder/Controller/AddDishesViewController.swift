//
//  AddDishesViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 10/2/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreData

extension AddDishesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController(){
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        imagepickercontroller.allowsEditing = true
        imagepickercontroller.sourceType = .photoLibrary
        
        present(imagepickercontroller, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickerImagesave.image = editedimage
        } else if let originalimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickerImagesave.image = originalimage
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
extension AddDishesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
//        currentOrderDetails.starfId = pickerData[row]
        pickerDataFirstValue = pickerData[row]
        
    }
    
    
}

//UINavigationControolerDelegate and UIImagePickerControllerDelegate class for image picker
class AddDishesViewController: UIViewController{

    
    @IBOutlet weak var dishCatpicker: UIPickerView!
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var mealPrice: UITextField!
    @IBOutlet weak var pickerImagesave: UIImageView!
    
    
   
    var pickerData = [String]()
    var dishitemselect: FoodItems?
    
    var pickerDataFirstValue: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerData = ["Entree", "Main", "Dessert"]
        print(dishitemselect?.fName ?? "")
        // Do any additional setup after loading the view.
        
        dishCatpicker.dataSource = self
        dishCatpicker.delegate = self
        
        
        if dishitemselect?.fName ?? "" != "" {
            setupLoadValue()
        }else{
            pickerDataFirstValue = "Entree"
        }
    }
    
    func setupLoadValue(){
        mealName.text = dishitemselect?.fName ?? ""
        mealPrice.text = String(describing: dishitemselect?.fPrice ?? 0)
        pickerImagesave.image =  UIImage(data: dishitemselect?.fImage as! Data)
        
        let mealcategory = dishitemselect?.fCategory ?? ""
        
        
        if mealcategory == "Main" {
            dishCatpicker.selectRow(1, inComponent: 0, animated: true)
            pickerDataFirstValue = "Main"
        }else if mealcategory == "Dessert" {
            dishCatpicker.selectRow(2, inComponent: 0, animated: true)
            pickerDataFirstValue = "Dessert"
        }else{
            dishCatpicker.selectRow(0, inComponent: 0, animated: true)
            pickerDataFirstValue = "Entree"
        }
        
        
    }
    
    func addValuetoCoreData(){
        print("picker value \(pickerDataFirstValue)")
        //coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FoodItem", in: context) // for added data
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem") // for get data
        
        let setOrder = NSManagedObject(entity: entity!, insertInto: context) // for added data
        
//        print("new value")
        setOrder.setValue(pickerDataFirstValue, forKey: "fCategory")
        setOrder.setValue(pickerImagesave.image?.pngData(), forKey: "fImage")
        setOrder.setValue(mealName.text, forKey: "fName")
        setOrder.setValue((mealPrice.text! as NSString).floatValue, forKey: "fPrice")
        
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let findpreviousvalue = data.value(forKey: "fName") as! String

                
                
                if findpreviousvalue == dishitemselect?.fName ?? "" {
//                    print("Equal value")
                    print("fetch value \(findpreviousvalue)")
                    print("comevalue value \(dishitemselect?.fName ?? "")")
                    //delete value
                    context.delete(data as! NSManagedObject)
                    return
                    
                }


            }
        }catch {
            print("fetch requesterror")
        }


        
        
        
        //        print(setOrder)
        do {
            try context.save()
            
        } catch {
            print("Failed saving")
        }
    }
    
    //
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        print("picker controller load")
        print("This is image \(image)")
        pickerImagesave.image = image
    }
    
    
    
    ////////
    @IBAction func addItemClicked(_ sender: Any) {
        //one controller view back
        _ = navigationController?.popViewController(animated: true)
        addValuetoCoreData()
    }

    @IBAction func uploadImageBut() {
        showImagePickerController()
        
    }

}

