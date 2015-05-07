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
            if let prods = json["product"].array{
                for prod in prods {
                    imagesURL.append(prod["Image"].string!)
                }
            }
        }
        ConnectionManager.sharedInstance.downloadImages(imagesURL)
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("TitleDidChange", object: "Category")
    }
    
    func importStructure()->[JSON]{
        var json: [JSON] =  [["ID":"1", "Name":"Tomates", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Tomates_4c245ab1487cf.gif", "product": [
            ["Name":"Tomate cherry", "PrixKilo":"7.40/ Kg", "Prix":"1.85", "Quantité":"250 grammes", "TypeCulture":"Hors-sol", "Provenance":"Vaud, Suisse", "Conditionnement":"Barquette de 250 grammes", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/product/Tomate_cherry_ba_4dd17c15deae1.jpg"],
            ["Name":"Tomate cherry grappe", "PrixKilo":"10.10/ Kg", "Prix":"5.05", "Quantité":"500 grammes", "TypeCulture":"", "Provenance":"", "Conditionnement":"", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/product/Tomate_cherry_gr_4c3ebac5582fe.jpg"],
            ["Name":"Tomate ronde", "PrixKilo":"3.70/ Kg", "Prix":"3.70", "Quantité":"1 kilo", "TypeCulture":"Hors-sol", "Provenance":"Vaud, Suisse", "Conditionnement":"", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/product/Tomate_ronde_4c11eddbc1add.jpg"]
            
        ]],
            ["ID":"2", "Name":"Salades, concombres", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Salades__concomb_4c08c7d1ca19d.gif", "product":[
                ["Name":"", "PrixKilo":"/ Kg", "Prix":"", "Quantité":"", "TypeCulture":"", "Provenance":"", "Conditionnement":"", "Image":""],
                ["Name":"", "PrixKilo":"/ Kg", "Prix":"", "Quantité":"", "TypeCulture":"", "Provenance":"", "Conditionnement":"", "Image":""]
            ]],
            ["ID":"3", "Name":"Légumes à racines", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/L__gumes____raci_4c23181fceee1.jpg"],
        ["ID":"4", "Name":"Poivrons, aubergines, courgettes", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Poivrons__auberg_4c0ca28242f34.gif"],
        ["ID":"5", "Name":"Choux, brocolis", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Choux__Broccoli_4c0f558bd6fcf.gif"],
        ["ID":"6", "Name":"Jeunes pousses", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Jeunes_pousses_4c0f51b485c93.gif"],
        ["ID":"7", "Name":"Autres Légumes", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Poireaux__fenoui_4caaebc29f975.jpg"],
        ["ID":"8", "Name":"Pommes de terre", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Pomme_de_terre_4c24705eab198.jpg"],
        ["ID":"9", "Name":"Asperges", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Asperges_4dc13c18011dd.jpg"],
        ["ID":"10", "Name":"Paniers fruits et légumes", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Paniers_de_saiso_4c4d3da32c346.jpg"],
        ["ID":"11", "Name":"Abonnements", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Abonnements_4e4900f4bf2f2.jpg"],
        ["ID":"12", "Name":"Uniquement BIO", "Image":"http://www.culti-shop.ch/components/com_virtuemart/shop_image/category/Uniquement_BIO_52949b04b0794.jpg"]]
        return json
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productStruct.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("category", forIndexPath: indexPath) as! UICollectionViewCell
        
        var lb: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        var im: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        if let str = productStruct[indexPath.row]["Name"].string {
            lb.text = str
        }
        if let url = productStruct[indexPath.row]["Image"].string{
            var localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
            localUrl += "/" + url.lastPathComponent
            im.image = UIImage(contentsOfFile: localUrl)
        }
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let productTable = segue.destinationViewController as! ProductTableViewController
            if let title = productStruct[(sender as! UICollectionViewCell).tag]["Name"].string{
                productTable.categoryName = title
                NSNotificationCenter.defaultCenter().postNotificationName("TitleDidChange", object: title)
            }
            if let products = productStruct[(sender as! UICollectionViewCell).tag]["product"].array{
                productTable.products = products
            }
        }
    }
    
    
}