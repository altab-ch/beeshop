//
//  FirstViewController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 24.04.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ConnectionManager.sharedInstance.pingServer({ (json) -> Void in
            println(json["Squeed"])
        }, errorHandler: { (error) -> Void in
            println(error)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

