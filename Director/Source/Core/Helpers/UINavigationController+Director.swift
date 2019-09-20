//
//  UINavigationController+Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

internal extension UINavigationController {
    
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
    
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool,
                             completion: @escaping ([UIViewController]?)->()) {
        
//        guard let idx = self.viewControllers.firstIndex(of: viewController),
//            (idx < (self.viewControllers.count - 1)) else {
//            completion(nil)
//            return
//        }
//
//        let newViewControllers = Array(self.viewControllers[0...idx])
//        let poppedViewControllers = Array(self.viewControllers[(idx + 1)..<self.viewControllers.count])
//
//        setViewControllers(
//            newViewControllers,
//            animated: animated,
//            completion: {
//                completion(poppedViewControllers)
//            })
        
        let poppedViewControllers = popToViewController(
            viewController,
            animated: animated
        )

        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion(poppedViewControllers)
            }
        }
        else {
            completion(poppedViewControllers)
        }
        
    }

    func setViewControllers(_ viewControllers: [UIViewController],
                            animated: Bool,
                            completion: @escaping ()->()) {
        
        setViewControllers(
            viewControllers,
            animated: animated
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
