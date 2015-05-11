//
//  MainNavigationController.swift
//  Beeshop
//
//  Created by Mathieu Knecht on 10.05.15.
//  Copyright (c) 2015 Mathieu Knecht. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: ENSideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = UINavigationController()
        
        sideMenu = ENSideMenu(sourceView: self.view, menuPosition:.Right)
        sideMenu?.menuWidth = self.view.bounds.size.width
        sideMenu?.bouncingEnabled = false
        
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
    }
    
}