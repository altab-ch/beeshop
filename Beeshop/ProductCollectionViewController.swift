//
//  ProductCollectionViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 05.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit

class ProductCollectionView: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("category", forIndexPath: indexPath) as? UICollectionViewCell
        cell!.backgroundColor = UIColor.orangeColor()
        return cell!
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}