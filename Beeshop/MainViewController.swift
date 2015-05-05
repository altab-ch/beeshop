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
    
    
    func importStructure()->JSON{
        var json: JSON =  [["ID":"1", "Name":"Tomates", "Image":""], ["ID":"2", "Name":"Salades, concombres", "Image":""], ["ID":"1", "Name":"Tomates", "Image":""]]
        return json
    }
}