//
//  BeeshopTests.swift
//  BeeshopTests
//
//  Created by Mathieu Knecht on 24.04.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import UIKit
import XCTest
import SwiftyJSON

class BeeshopTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPerformanceServer() {
        
        self.measureBlock() {
            let expectation = self.expectationWithDescription("performance server")
            ConnectionManager.sharedInstance.pingServer({(json: JSON)->Void in
                    expectation.fulfill()
                
                }, errorHandler: { (error: NSError?) -> Void in
                    expectation.fulfill()
            })
            
            self.waitForExpectationsWithTimeout(5) { (error) in
                
            }
        }
        
    }
    
    func testPingServer(){
        
        let expectation = expectationWithDescription("ping server")
        
        ConnectionManager.sharedInstance.pingServer({(json: JSON)->Void in
            if let ping = json["Squeed"].string {
                XCTAssertTrue(ping == "Hello world post !!", "Issue with server ping")
            } else {
                println(json["Squeed"].error)
                XCTAssertTrue(false, "Issue with json decoding")
            }
            expectation.fulfill()
            
        }, errorHandler: { (error: NSError?) -> Void in
            XCTAssertTrue(false, "Issue with server connection")
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5) { (error) in
            
        }
    }
    
}
