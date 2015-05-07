//
//  MainViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 04.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class MainViewController: UIViewController {
    
    var listingNavVC : UINavigationController?
    
    @IBOutlet weak var lbCategory: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "titleDidChange:", name:"TitleDidChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addProductToBasket:", name:"AddProductToBasket", object: nil)
        
    }
    
    override func viewDidLoad() {
        listingNavVC = self.childViewControllers[0] as? UINavigationController
        
    }
    
    func titleDidChange(notification: NSNotification){
        let str = notification.object as! String
        lbCategory.text = str
    }
    
    @IBAction func btTitlePressed(sender: AnyObject) {
        listingNavVC?.popViewControllerAnimated(true)
    }
    
    @IBAction func addProductToBasket(sender: AnyObject) {
        
    }
}