//
//  ViewCoordinator+Modal.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public extension ViewCoordinator /* Modal */ {
    
    /// Flag indicating if the view coordinator presents it's root view controller modally.
    ///
    /// This will always return `false` until the view coordinator has been started.
    var isModal: Bool {
        return (self.rootViewController is UINavigationController)
    }
    
    /// Presents a view controller modally from the view coordinator's navigation controller.
    /// - Parameter viewController: The view controller to present.
    /// - Parameter animated: Flag indicating if the presentation should be performed with an animation; _defaults to true_.
    /// - Parameter completion: An optional completion handler to call after the modal presentation finishes; _defaults to nil_.
    final func modal(_ viewController: UIViewController,
               animated: Bool = true,
               completion: (()->())? = nil) {
        
        self.navigationController.present(
            viewController,
            animated: animated,
            completion: completion
        )
        
    }
    
    // MARK: Private
    
    internal var containsChildModals: Bool {
        
        guard !self.children.isEmpty else { return false }
        
        for child in self.children {
            
            if childIsOrContainsModals(child) {
                return true
            }
            
        }
        
        return false
        
    }
    
    private func childIsOrContainsModals(_ child: ViewCoordinator) -> Bool {
     
        guard !child.isModal else { return true }
        guard !child.children.isEmpty else { return false }
        
        for subChild in child.children {
            
            if child.childIsOrContainsModals(subChild) {
                return true
            }
            
        }
        
        return false
        
    }
    
}
