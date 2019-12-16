//
//  MMHomeViewController.swift
//  MoneyMonitor
//
//  Created by Lavanya on 06/12/19.
//  Copyright © 2019 Lavanya. All rights reserved.
//

import UIKit

class MMHomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var transactionCollectionView: UICollectionView!
    @IBOutlet weak var addTransactionButton: UIButton!
    var lastVelocityYSign = 0
    var homeViewModel = MMHomeViewModel()
    var toptransactionModel = MMTopTransactionDetailsModel()
    @IBOutlet var addTransactionView: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var notesTextField: UITextField!
    
    @IBOutlet weak var topTransactionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateTextField.text = getCurrentDate()
        dateTextField.addTarget(self, action: #selector(datePicker(_:)), for: .allTouchEvents)
        categoryTextField.addTarget(self, action: #selector(showCategoryList), for: .allTouchEvents)
         amountTextField.addTarget(self, action: #selector(showNumberPad), for: .allTouchEvents)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topTransactionCollectionView.layer.shadowColor = UIColor.black.cgColor
        topTransactionCollectionView.layer.shadowOpacity = 1
        topTransactionCollectionView.layer.shadowOffset = .zero
        topTransactionCollectionView.layer.shadowRadius = 3
        topTransactionCollectionView.clipsToBounds = false
        topTransactionCollectionView.layer.masksToBounds = false
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == transactionCollectionView{
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign &&
            currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        if lastVelocityYSign > 0 {
            print("SCROLLING DOWN")
            UIView.animate(withDuration: 0.9) {
                
                self.addTransactionButton.setTitle("Add transaction", for: .normal)
                self.addTransactionButton.layer.cornerRadius = 20
            }
            
        } else if lastVelocityYSign < 0 {
            UIView.animate(withDuration: 0.9) {
                self.addTransactionButton.setTitle("", for: .normal)
                self.addTransactionButton.contentMode = .center
                self.addTransactionButton.layer.cornerRadius = 15 //self.addTransactionButton.frame.width/2
            }
            
            print("SCOLLING UP")
        }
    }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == topTransactionCollectionView{
            return 1
        }else{
        return homeViewModel.configureNumberOfSections(collectionView:collectionView)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topTransactionCollectionView{
            return toptransactionModel.transactionNameList.count
        }else{
        return homeViewModel.configureNumberOfItemsInSections(collectionView: collectionView, numberOfItemsInSection: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topTransactionCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath)as! MMTopTransactionCollectionViewCell
            cell.nameLabel.sizeToFit()
            let keys = Array(toptransactionModel.transactionNameList.keys)
            cell.nameLabel.text = keys[indexPath.row]
            let values = Array(toptransactionModel.transactionNameList.values)
            cell.amountLabel.text = String(values[indexPath.row])
            cell.amountLabel.sizeToFit()
            return cell
        }
        else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! MMTansactionCollectionViewCell
        homeViewModel.configure(collectionViewCell:cell, indexPath:indexPath)
        return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? MMTransactionCollectionReusableView{
            sectionHeader.sectionDatelabel.text = "23 thu,2019"
            
            sectionHeader.totalAmountlabel.text = " 12227999 "
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == topTransactionCollectionView{
//        let label = UILabel(frame: CGRect.zero)
//             let keys = Array(toptransactionModel.transactionNameList.keys)
//        label.text = keys[indexPath.item]
//        label.sizeToFit()
//        return CGSize(width: label.frame.width, height: 32)
//        }
//        return CGSize(width: 0, height: 0)
//        
//    }
    
    @IBAction func addTransactionAction(_ sender: UIButton) {
        
        addTransactionView.center = self.view.center
        self.transactionCollectionView.backgroundColor = UIColor.lightGray
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.addSubview(self.addTransactionView)
            
        }, completion: nil)
        
        //        UIView.transition(with: addTransactionView, duration: 0.5, options: .transitionFlipFromRight, animations: {
        //        }, completion: nil)
        //        //        UIView.transition(from: self.view, to: addTransactionView, duration: 0.5, options: .transitionFlipFromLeft) { (true) in
        //        //            self.view.addSubview(self.addTransactionView)
        //        //
        //        //        }
        //        UIView.animate(withDuration: 0.5) {
        //            self.view.addSubview(self.addTransactionView)
        //
        //        }
        
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.transactionCollectionView.backgroundColor = UIColor.clear
        
        addTransactionView.removeFromSuperview()
    }
    
    @IBAction func datePicker(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func getCurrentDate()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from:Date())
        print(dateString)
        return dateString
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dateTextField = textField
        datePicker(textField)

    }
    
    @objc func showCategoryList(){
        let vc = MMCategoryTableViewController()
        vc.categoryDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    @objc func showNumberPad(){
        amountTextField.keyboardType = .numberPad
    }
}
extension MMHomeViewController:MMCategoryTableViewControllerDelegate{
    func sendCategory(name: String) {
        categoryTextField.text = name
    }
    
    
    
}
