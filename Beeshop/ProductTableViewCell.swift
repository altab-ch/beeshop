//
//  ProductTableViewCell.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 08.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductTableViewCell: UITableViewCell {
    
    var product : JSON = [:]
    var localUrl : String = ""
    
    func setProduct(prod : JSON) {
        
        product = prod
        
        var name: UILabel = self.viewWithTag(2) as! UILabel
        var quantite: UILabel = self.viewWithTag(3) as! UILabel
        var prix: UILabel = self.viewWithTag(4) as! UILabel
        var im: UIImageView = self.viewWithTag(1) as! UIImageView
        
        if let str = product["Name"].string {
            name.text = str
        }
        if let str = product["Prix"].double {
            prix.text = "CHF "+String(format:"%.2f",str)
        }
        if let str = product["Quantité"].string {
            quantite.text = str
        }
        
        if let url = product["Image"].string{
            localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
            localUrl += "/" + url.lastPathComponent
            im.image = UIImage(contentsOfFile: localUrl)
        }
    }
    
    @IBAction func btAddPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("AnimateImageProductMain", object: nil, userInfo: ["url" : localUrl, "y" : self.frame.origin.y, "product" : product.rawValue])
    }
}