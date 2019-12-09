//
//  MMHomeViewModel.swift
//  MoneyMonitor
//
//  Created by Lavanya on 08/12/19.
//  Copyright © 2019 Lavanya. All rights reserved.
//

import UIKit

class MMHomeViewModel: NSObject {
   private var lastVelocityYSign = 0

    
    func configureNumberOfSections(collectionView: UICollectionView)-> Int{
        return 4
    }
    
    func configureNumberOfItemsInSections(collectionView: UICollectionView, numberOfItemsInSection section: Int)-> Int{
        return 3
    }
    
    func configure(collectionViewCell:MMTansactionCollectionViewCell, indexPath:IndexPath){
        collectionViewCell.titleLabel.text = "dhfjsd"
        collectionViewCell.descriptionLabel.text = "vshdfvdjhs"
        collectionViewCell.amountLabel.text = "1000"
    }

}
