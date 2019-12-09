//
//  MMCategoryModel.swift
//  MoneyMonitor
//
//  Created by Lavanya on 09/12/19.
//  Copyright © 2019 Lavanya. All rights reserved.
//

import UIKit


class MMCategoryModel {
    var categoryList = [String]()
    var imageList = [UIImage]()
    
    
    init() {
    categoryList = ["Beauty","Clothing","Entertainment","Food","Fuel","Grocery","Health","Rent","Salary","Savings","Shopping","Travel"]
        imageList  = [UIImage(named: "PlusImage"),UIImage(named: "MinusImage")] as! [UIImage]
    }
}
