//
//  MMTopTransactionDetailsModel.swift
//  MoneyMonitor
//
//  Created by Lavanya on 10/12/19.
//  Copyright © 2019 Lavanya. All rights reserved.
//

import UIKit

class MMTopTransactionDetailsModel {
    var transactionNameList = [String:Double]()

    init() {
        transactionNameList = ["Expense":45,"Income":66,"Balance": 64,"CarryForward":66,"Balance with C/F":88]
    }

}
