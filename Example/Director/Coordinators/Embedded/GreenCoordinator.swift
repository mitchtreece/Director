//
//  GreenCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Director

class GreenCoordinator: ViewCoordinator {
    
    override func build() -> UIViewController {
        
        let vc = EmbeddedChildViewController()
            .setup(delegate: self)
        
        vc.title = "Green"
        vc.tabBarItem.title = vc.title
        vc.view.backgroundColor = UIColor.green
        
        return UINavigationController(rootViewController: vc)
        
    }
    
}

extension GreenCoordinator: EmbeddedChildViewControllerDelegate {
    
    func embeddedChildViewControllerDidTapPush(_ viewController: EmbeddedChildViewController) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.random
        vc.title = "Green Detail"
        
        push(vc)
        
    }
    
    func embeddedChildViewControllerDidTapModal(_ viewController: EmbeddedChildViewController) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.random
        vc.title = "Green Modal"
        
        modal(UINavigationController(rootViewController: vc))
        
    }
    
    func embeddedChildViewControllerDidTapDone(_ viewController: EmbeddedChildViewController) {
        (self.parentCoordinator as? EmbeddedCoordinator)?.finish()
    }
    
}
