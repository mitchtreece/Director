//
//  UINavigationController+Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (()->())?) {

        pushViewController(
            viewController,
            animated: animated
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }
    
    func popViewController(animated: Bool,
                           completion: (()->())?) {
        
        popViewController(animated: true)
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }
    
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (()->())?) {
        
        popToViewController(
            viewController,
            animated: animated
        )

        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }
    
    func popToRootViewController(animated: Bool,
                                 completion: (()->())?) {
        
        popToRootViewController(animated: animated)

        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }

    func setViewControllers(_ viewControllers: [UIViewController],
                            animated: Bool,
                            completion: (()->())?) {
        
        setViewControllers(
            viewControllers,
            animated: animated
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                self.viewControllers = viewControllers
                completion?()
            }
        }
        else {
            self.viewControllers = viewControllers
            completion?()
        }
        
    }
    
}
