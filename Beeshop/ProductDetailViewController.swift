//
//  ProductDetailViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 07.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductDetailViewController: UIViewController {
    
    var product : JSON = [:]
    
    @IBOutlet weak var im: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantite: UILabel!
    @IBOutlet weak var prixKilo: UILabel!
    @IBOutlet weak var prix: UILabel!
    @IBOutlet weak var desc1: UILabel!
    @IBOutlet weak var desc2: UILabel!
    @IBOutlet weak var desc3: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        if let str = product["Name"].string {
            name.text = str
        }
        if let str = product["Prix"].string {
            prix.text = "CHF "+str
        }
        if let str = product["Quantité"].string {
            quantite.text = str
        }
        
        if let url = product["Image"].string{
            var localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
            localUrl += "/" + url.lastPathComponent
            im.image = UIImage(contentsOfFile: localUrl)
        }
    }
    
    
    
}