//
//  Order+CoreDataProperties.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/28/19.
//  Copyright © 2019 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var orderTime: NSDate?
    @NSManaged public var starfId: String?
    @NSManaged public var orderItems: NSObject?
    @NSManaged public var totalCost: Float
    @NSManaged public var memberOfTable: Int16

}
