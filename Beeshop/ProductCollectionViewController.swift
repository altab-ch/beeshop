//
//  ProductCollectionViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 05.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductCollectionView: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var productStruct: [JSON] = []
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        productStruct = self.importStructure()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "downloadImagesDidFinish:", name:"DownloadImagesDidFinish", object: nil)
    }
    
    func downloadImagesDidFinish(notification: NSNotification){
        println("dl images over")
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        var imagesURL : [String] = []
        for json in productStruct {
            imagesURL.append(json["Image"].string!)
        }
        ConnectionManager.sharedInstance.downloadImages(imagesURL)
    }
    
    func importStructure()->[JSON]{
        var json: [JSON] =  [["ID":"1", "Name":"Tomates", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Tomates_4c245ab1487cf.gif"], ["ID":"2", "Name":"Salades, concombres", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Salades__concomb_4c08c7d1ca19d.gif"], ["ID":"1", "Name":"Légumes à racines", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/L__gumes____raci_4c23181fceee1.jpg"]]
        return json
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productStruct.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("category", forIndexPath: indexPath) as? UICollectionViewCell
        var lb: UILabel = cell!.viewWithTag(1) as! UILabel
        var im: UIImageView = cell?.viewWithTag(2) as! UIImageView
        if let str = productStruct[indexPath.row]["Name"].string {
            lb.text = str
        }
        if let url = productStruct[indexPath.row]["Image"].string{
            var localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
            localUrl += "/" + url.lastPathComponent
            im.image = UIImage(contentsOfFile: localUrl)
        }
        
        return cell!
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}