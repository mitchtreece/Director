//
//  RedCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Director

class RedCoordinator: ViewCoordinator {
    
    override func build() -> UIViewController {
        
        let vc = EmbeddedChildViewController()
            .setup(delegate: self)
        
        vc.title = "Red"
        vc.tabBarItem.title = vc.title
        vc.view.backgroundColor = UIColor.red
        
        return UINavigationController(rootViewController: vc)
        
    }
    
}

extension RedCoordinator: EmbeddedChildViewControllerDelegate {
    
    func embeddedChildViewControllerDidTapPush(_ viewController: EmbeddedChildViewController) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.random
        vc.title = "Red Detail"
        
        push(vc)
        
    }
    
    func embeddedChildViewControllerDidTapModal(_ viewController: EmbeddedChildViewController) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.random
        vc.title = "Red Modal"
        
        modal(UINavigationController(rootViewController: vc))
        
    }
    
    func embeddedChildViewControllerDidTapDone(_ viewController: EmbeddedChildViewController) {
        (self.parentCoordinator as? EmbeddedCoordinator)?.finish()
    }
    
}
