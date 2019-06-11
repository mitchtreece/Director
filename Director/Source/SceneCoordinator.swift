//
//  SceneCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

open class SceneCoordinator: AnyCoordinator {
    
    internal weak var director: Director!
    
    private var window: UIWindow {
        return self.director.window
    }
    
    private var navigationController: UINavigationController {
        return self.director.navigationController
    }
    
    private var rootCoordinator: ViewCoordinator!
    
    // MARK: Public
    
    public init() {
        //
    }
    
    open func build() -> ViewCoordinator {
        fatalError("SceneCoordinator must return an initial ViewCoordinator")
    }
    
    // MARK: Private
    
    internal func buildForDirector() -> ViewCoordinator {
        
        let coordinator = build()
        self.rootCoordinator = coordinator
        return coordinator
        
    }
    
    internal func replaceRoot(with coordinator: ViewCoordinator, animated: Bool = true) {
        
        guard let viewController = UIViewController.root(in: coordinator.build()) else {
            fatalError("Failed to load root view controller")
        }
        
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.navigationController
        self.rootCoordinator = coordinator
        
        guard animated else {
            
            self.navigationController.setViewControllers([viewController], animated: false)
            self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
            self.rootCoordinator.didStart()
            
            return
            
        }
        
        if let transitioningDelegate = viewController.transitioningDelegate,
            let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
            
            self.navigationController.delegate = transitioningNavDelegate
            
            self.navigationController.pushViewController(viewController, completion: {
                self.navigationController.setViewControllers([viewController], animated: false)
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.didStart()
            })
            
        }
        else {
            
            self.navigationController.setViewControllers([viewController], animated: true)
            self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
            self.rootCoordinator.didStart()
            
        }
        
    }
    
}
