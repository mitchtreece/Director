//
//  ViewCoordinatorPresentationDelegate.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

internal class ViewCoordinatorPresentationDelegate: NSObject, UINavigationControllerDelegate {
    
    private weak var coordinator: ViewCoordinator?
    
    internal var isEnabled: Bool = true
    
    internal init(coordinator: ViewCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: UIViewController
    
    func viewControllerIsBeingDismissed(_ viewController: UIViewController) {
        
        guard let coordinator = self.coordinator, self.isEnabled else { return }
        guard !coordinator.isFinishedAndRemoved else { return }
        
        (coordinator.parentCoordinator as? ViewCoordinator)?
            .removeForModalDismiss(child: coordinator)
        
    }
    
    // MARK: UINavigationController
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
        guard let coordinator = self.coordinator, self.isEnabled else { return }
        
        // Grab source view controller and make sure it was popped
        
        guard let sourceViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(sourceViewController) else { return }
        
        // Are we popping the coordinator's initial view controller?
        
        guard sourceViewController == coordinator.rootViewController else { return }
        
        // Remove self from parent without attempting to dismiss the view controller
        
        (coordinator.parentCoordinator as? ViewCoordinator)?
            .removeForNavigationPop(child: coordinator)
        
    }
    
}
