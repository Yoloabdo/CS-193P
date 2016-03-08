//
//  collictionCell.swift
//  SmashTag
//
//  Created by abdelrahman mohamed on 3/7/16.
//  Copyright © 2016 Abdulrhman dev. All rights reserved.
//

import UIKit

class collictionCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
            
            collectionView.delegate = dataSourceDelegate
            collectionView.dataSource = dataSourceDelegate
            collectionView.tag = row
            collectionView.reloadData()
    }


}
