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
    
    func downloadImages(list: [String]){
        var ls : NSMutableArray = NSMutableArray()
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .LibraryDirectory, domain: .UserDomainMask)
        let localUrl = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] as! String
        
        for url in list {
            if !NSFileManager.defaultManager().fileExistsAtPath(localUrl+"/"+url.lastPathComponent){
                ls.addObject(url)
            }
        }
        
        let tempLst = ls as NSArray as! [String]
        
        for url in tempLst {
            Alamofire.download(.GET, url, destination).response({ (req, res, data, err) -> Void in
                
                ls.removeObject(url)
                
                if (ls.count == 0) {
                    NSNotificationCenter.defaultCenter().postNotificationName("DownloadImagesDidFinish", object: nil)
                }
                
            })
            
        }
        
        
        
    }
}