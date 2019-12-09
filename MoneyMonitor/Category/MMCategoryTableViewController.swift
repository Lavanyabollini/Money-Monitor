//
//  MMCategoryTableViewController.swift
//  MoneyMonitor
//
//  Created by Lavanya on 09/12/19.
//  Copyright © 2019 Lavanya. All rights reserved.
//

import UIKit
protocol MMCategoryTableViewControllerDelegate {
    func sendCategory(name:String)
}

class MMCategoryTableViewController: UITableViewController {
var categoryModel = MMCategoryModel()
    var categoryDelegate:MMCategoryTableViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.register(MMCategoryHeaderViewCell.self, forCellReuseIdentifier: "HeaderView")
        tableView.tableFooterView = UIView(frame: .zero)
tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryModel.categoryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.imageView?.image = categoryModel.imageList[indexPath.row]
        cell.imageView?.image = UIImage(named:"MenuImage")
    cell.textLabel?.text = categoryModel.categoryList[indexPath.row]
        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "HeaderView") as? MMCategoryHeaderViewCell
        cell?.textLabel?.text = "Select Category"
        let font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)!

        cell?.textLabel?.font = font
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
categoryDelegate?.sendCategory(name:categoryModel.categoryList[indexPath.row] )
        dismiss(animated: true, completion: nil)
        
    }
}
