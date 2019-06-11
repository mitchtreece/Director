//
//  ViewCoordinator+Navigation.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public extension ViewCoordinator /* Navigation */ {
    
    final func push(_ viewController: UIViewController,
              animated: Bool = true,
              completion: (()->())? = nil) {
        
        guard animated else {
            
            self.navigationController.pushViewController(
                viewController,
                animated: false
            )
            
            completion?()
            return
            
        }
        
        self.navigationController.pushViewController(
            viewController,
            completion: completion
        )
        
    }
    
}
