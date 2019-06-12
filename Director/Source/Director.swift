//
//  Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public class Director {
    
    internal private(set) var window: UIWindow
    private var sceneCoordinator: SceneCoordinator
    
    public var navigationController: UINavigationController {
        
        if let nav = self.window.rootViewController as? UINavigationController {
            return nav
        }
        
        fatalError("Director's managed window must have a navigation controller at its root")
        
    }
    
    public init(_ coordinator: SceneCoordinator, window: UIWindow) {
        
        self.window = window
        self.window.rootViewController = self.window.rootViewController ?? UINavigationController()
        
        if !self.window.isKeyWindow {
            self.window.makeKeyAndVisible()
        }
        
        self.sceneCoordinator = coordinator
        self.sceneCoordinator.director = self
        
        UIViewController.director_swizzle()
        
    }
    
    public final func start() -> Self {
        
        let coordinator = self.sceneCoordinator.buildForDirector()
        coordinator.parentCoordinator = self.sceneCoordinator
        
        let viewController = coordinator.build()
        viewController.viewCoordinatorPresentationDelegate = coordinator.presentationDelegate
        coordinator.rootViewController = viewController
        
        guard let rootViewController = UIViewController.root(in: viewController) else {
            fatalError("Director failed to load the scene coordinator's initial child view controller")
        }
        
        self.navigationController.setViewControllers([rootViewController], animated: false)
        coordinator.navigationController = self.navigationController
        coordinator.navigationController.delegate = coordinator.presentationDelegate
        coordinator.didStart()
        
        return self
        
    }
    
}
