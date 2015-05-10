//
//  CartViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 08.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbTotal: UILabel!
    
    var products = Basket.sharedInstance.products
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "basketTotalUpdated:", name:"BasketTotalUpdated", object: nil)
    }
    
    override func viewDidLoad() {
        self.updateTotal()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("panier") as! UITableViewCell
        var lbName: UILabel = cell.contentView.viewWithTag(2) as! UILabel
        var im: UIImageView = cell.contentView.viewWithTag(1) as! UIImageView
        var quantite : UITextField = cell.contentView.viewWithTag(3) as! UITextField
        var btDelete : BasketDeleteButton = cell.contentView.viewWithTag(5) as! BasketDeleteButton
        
        let product = products[indexPath.row]
        btDelete.IDProduct = product["ID"].stringValue
        
        lbName.text = product["Name"].stringValue
        
        if let url = product["Image"].string{
            var localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
            localUrl += "/" + url.lastPathComponent
            im.image = UIImage(contentsOfFile: localUrl)
        }
        
        quantite.text = String(product["QuantiteBasket"].intValue)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("header") as! UITableViewCell
        return headerCell
    }
    
    @IBAction func btDeletePressed(sender: BasketDeleteButton) {
        tableView.beginUpdates()
        if products.count > 0 {
            for ind in 0...products.count-1{
                if products[ind]["ID"].string == sender.IDProduct{
                    tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: ind, inSection: 0)], withRowAnimation: .Fade)
                    break
                }
            }
        }
        Basket.sharedInstance.deleteProduct(sender.IDProduct)
        products = Basket.sharedInstance.products
        
        tableView.endUpdates()
        self.updateTotal()
    }
    
    @IBAction func btValiderPressed(sender: AnyObject) {
        
    }
    
    func updateTotal(){
        lbTotal.text = String(format:"%.2f",Basket.sharedInstance.getTotal()) + " CHF"
    }
    
    /*func basketTotalUpdated(notification: NSNotification){
        lbTotal.text = String(format:"%.2f",Basket.sharedInstance.getTotal()) + " CHF"
    }*/
}