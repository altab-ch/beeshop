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
        var cell = tableView.dequeueReusableCellWithIdentifier("product") as! ProductTableViewCell
        
        cell.setProduct(products[indexPath.row])
        cell.tag = indexPath.row
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let cell = sender as! ProductTableViewCell
            let detailVC = segue.destinationViewController as! ProductDetailViewController
            NSNotificationCenter.defaultCenter().postNotificationName("TitleDidChange", object: cell.product["Name"].string)
            detailVC.product = cell.product
        }
    }
    
}