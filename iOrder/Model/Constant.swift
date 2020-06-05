//
//  Constant.swift
//  iOrder
//
//  Created by Randika Wanninayaka on 9/27/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public var currentOrderDetails = OrderDetails(orderTime: nil, starfId: "", orderItems: nil, totalCost: 0.0, memberOfTable: "")

//public var waiterID: String = ""
public var selectArr = [String]()
public var fetchselectedarray = [FoodItemsNotImg]()
//public var memberOfTablevalue: String = ""


public struct OrderDetails {
    var orderTime: NSDate?
    var starfId: String?
    var orderItems: NSObject?
    var totalCost: Float
    var memberOfTable: String
}

public struct FoodItems {
    var fCategory: String
    var fImage: NSData
    var fName: String
    var fPrice: Float
    
}

public struct FoodItemsNotImg {
    var fCategory: String
    var fName: String
    var fPrice: Float
    
}

