//
//  ConnectionManager.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 29.04.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ConnectionManager {
    
    static let sharedInstance = ConnectionManager()
    
    func pingServer(completion:(json: JSON)->Void, errorHandler:(error: NSError?)->Void){
        Alamofire.request(.POST, "http://www.altab.ch/squeed/")
            .responseJSON { (_, _, JSONdata, error) in
                if ((error) != nil)
                {
                    errorHandler(error: error)
                }
                else
                {
                    let json = JSON(JSONdata!)
                    completion(json: json)
                }
            }
        
    }
}