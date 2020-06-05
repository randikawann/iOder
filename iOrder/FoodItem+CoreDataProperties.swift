//
//  FoodItem+CoreDataProperties.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 10/1/19.
//  Copyright © 2019 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var fCategory: String?
    @NSManaged public var fImage: NSData?
    @NSManaged public var fName: String?
    @NSManaged public var fPrice: Float

}
