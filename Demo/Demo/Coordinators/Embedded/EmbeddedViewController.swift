//
//  EmbeddedViewController.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class EmbeddedViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(
            true,
            animated: true
        )
        
    }
    
}
