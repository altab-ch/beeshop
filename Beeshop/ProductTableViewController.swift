//
//  ProductTableViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 05.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductTableViewController: UITableViewController {
    var products : [JSON] = []
    var categoryName : String = ""
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("TitleDidChange", object: categoryName)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("product") as! UITableViewCell
        var name: UILabel = cell.viewWithTag(2) as! UILabel
        var quantite: UILabel = cell.viewWithTag(3) as! UILabel
        var prix: UILabel = cell.viewWithTag(4) as! UILabel
        var im: UIImageView = cell.viewWithTag(1) as! UIImageView
        
        if let str = products[indexPath.row]["Name"].string {
            name.text = str
        }
        if let str = products[indexPath.row]["Prix"].string {
            prix.text = "CHF "+str
        }
        if let str = products[indexPath.row]["Quantité"].string {
            quantite.text = str
        }
        
        if let url = products[indexPath.row]["Image"].string{
            var localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
            localUrl += "/" + url.lastPathComponent
            im.image = UIImage(contentsOfFile: localUrl)
        }
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let cell = sender as! UITableViewCell
            let detailVC = segue.destinationViewController as! ProductDetailViewController
            NSNotificationCenter.defaultCenter().postNotificationName("TitleDidChange", object: products[cell.tag]["Name"].string)
            detailVC.product = products[cell.tag]
        }
    }
    
}