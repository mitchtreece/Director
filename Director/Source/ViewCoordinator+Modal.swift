//
//  ViewCoordinator+Modal.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public extension ViewCoordinator /* Modal */ {
    
    final func modal(_ viewController: UIViewController,
               animated: Bool = true,
               completion: (()->())? = nil) {
        
        self.navigationController.present(
            viewController,
            animated: animated,
            completion: completion
        )
        
    }
    
}
