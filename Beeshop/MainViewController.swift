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
    
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "titleDidChange:", name:"TitleDidChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "basketTotalUpdated:", name:"BasketTotalUpdated", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "animateImageProductMain:", name:"AnimateImageProductMain", object: nil)
        
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav-back-portrait"), forBarMetrics: .Default)
        listingNavVC = self.childViewControllers[0] as? UINavigationController
        self.setTotal()
    }
    
    func titleDidChange(notification: NSNotification){
        let str = notification.object as! String
        lbCategory.text = str
    }
    
    func basketTotalUpdated(notification: NSNotification){
        self.setTotal()
    }
    
    func animateImageProductMain(notification: NSNotification){
        var im = UIImageView(image : UIImage(contentsOfFile: notification.userInfo!["url"] as! String))
        im.frame = CGRect(x: 5, y: (notification.userInfo!["y"] as! Int)+122, width: 85, height: 73)
        
        self.view.addSubview(im)
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            im.frame = CGRect(x: self.view.frame.size.width-85, y: 100, width: 20, height: 18)
        }) { (Bool) -> Void in
            Basket.sharedInstance.addProduct(JSON(notification.userInfo!["product"]!))
            im.removeFromSuperview()
        }
    }
    
    func setTotal(){
        lbTotal.text = String(format:"%.2f",Basket.sharedInstance.getTotal()) + " CHF"
    }
    
    @IBAction func btTitlePressed(sender: AnyObject) {
        listingNavVC?.popViewControllerAnimated(true)
    }
    
}