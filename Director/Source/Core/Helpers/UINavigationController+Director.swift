//
//  UINavigationController+Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

internal extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, completion: (()->())?) {
        
        pushViewController(
            viewController,
            animated: true
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
    
    func popToViewController(_ viewController: UIViewController, completion: @escaping ([UIViewController]?)->()) {
        
        guard let idx = self.viewControllers.firstIndex(of: viewController),
            (idx < (self.viewControllers.count - 1)) else {
            completion(nil)
            return
        }

        let newViewControllers = Array(self.viewControllers[0...idx])
        let poppedViewControllers = Array(self.viewControllers[(idx + 1)..<self.viewControllers.count])
        
        setViewControllers(newViewControllers, completion: {
            completion(poppedViewControllers)
        })
        
//        let poppedViewControllers = popToViewController(
//            viewController
//            animated: true
//        )
//
//        if let coordinator = self.transitionCoordinator {
//            coordinator.animate(alongsideTransition: nil) { _ in
//                completion(poppedViewControllers)
//            }
//        }
//        else {
//            completion(poppedViewControllers)
//        }
        
    }

    func setViewControllers(_ viewControllers: [UIViewController], completion: @escaping ()->()) {
        
        setViewControllers(
            viewControllers,
            animated: true
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        }
        else {
            completion()
        }
        
    }
    
}
