//
//  Basket.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 08.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import SwiftyJSON

class Basket {
    static let sharedInstance = Basket()
    
    var products : [JSON] = []
    
    required init () {
        
    }
    
    func addProduct (product : JSON){
        
        var found = false
        if products.count > 0 {
            for ind in 0...products.count-1{
                if products[ind]["ID"].string == product["ID"].stringValue{
                    found = true
                    products[ind]["QuantiteBasket"].int = products[ind]["QuantiteBasket"].intValue + 1
                }
            }
        }
        
        if !found {
            var prodtemp = product
            prodtemp["QuantiteBasket"].int = 1
            products.append(prodtemp)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("BasketTotalUpdated", object: nil)
    }
    
    func getTotal()->Double{
        
        var total : Double = 0.0
        
        for prod in products {
            if let prix = prod["Prix"].double{
                if let nb = prod["QuantiteBasket"].int{
                    total += prix*Double(nb)
                }
            }
        }
        
        return total
    }
}