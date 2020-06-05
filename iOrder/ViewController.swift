//
//  ViewController.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setGradientBackground()
        
        isfirsttimeopen()
        // Do any additional setup after loading the view.
    }

    func isfirsttimeopen(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            //Add default food items to Coredata
            addFoodItemCoreData()
        }
    }
    
    func addFoodItemCoreData(){
        let foodvalue = [
            ["Entree", "entree1", "Vegetarian Mini Spring Rolls", "4.80"],
            ["Entree", "entree2", "Mini Spring Rolls", "4.80"],
            ["Entree", "entree3", "Home made Dim Sims", "4.80"],
            ["Entree", "entree4", "Deep Fried Chicken wings", "4.80"],
            ["Entree", "entree5", "King Prawn Cutlets", "6.80"],
            ["Entree", "entree6", "Prawn Cocktail", "6.90"],
            ["Entree", "entree7", "Garlic King prawns", "10.00"],
            ["Entree", "entree8", "Prawn chips", "2.80"],
            ["Main", "main1", "Sweet and Sour Pork", "6.90"],
            ["Main", "main2", "Kung Pao Chicken", "7.95"],
            ["Main", "main3", "Mapo Tofu", "7.95"],
            ["Main", "main4", "Wontongs", "6.55"],
            ["Main", "main5", "Dumplings", "7.00"],
            ["Main", "main6", "Chow Mein", "8.99"],
            ["Main", "main7", "Peking Roasted Duck", "10.00"],
            ["Dessert", "dessert1", "Sticky rice Cakes", "4.90"],
            ["Dessert", "dessert2", "Black Sesame Rice Balls", "4.90"],
            ["Dessert", "dessert3", "Water Chesnut Cake", "5.00"],
            ["Dessert", "dessert4", "Sweet red bean soup", "5.90"],
            ["Dessert", "dessert5", "Sesame Fritters", "3.90"],
            ["Dessert", "dessert6", "Osmanthus Jelly", "4.90"],
            ["Dessert", "dessert7", "Crispy peanut Dumplings", "7.90"],
        ]
        
        _ = [FoodItems]()
        
        //coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FoodItem", in: context)
        
        for item in foodvalue {
           
            let setOrder = NSManagedObject(entity: entity!, insertInto: context)
            
            setOrder.setValue(item[0], forKey: "fCategory")
            setOrder.setValue(UIImage(named: item[1])?.pngData(), forKey: "fImage")
            setOrder.setValue(item[2], forKey: "fName")
            setOrder.setValue(Float(item[3]), forKey: "fPrice")


            


            do {
                try context.save()

            } catch {
                print("Failed saving")
            }
            
            
            
        }
        
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red:0.79, green:0.39, blue:0.40, alpha:1.0).cgColor
        let colorBottom = UIColor(red:0.56, green:0.19, blue:0.45, alpha:1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }


}

