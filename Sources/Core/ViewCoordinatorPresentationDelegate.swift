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
        guard !coordinator.isFinished else { return }
        
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
        
        guard sourceViewController != navigationController else {
            
            // This delegate function gets called whenever
            // UIViewController's `viewDidAppear(animated:)` is called.
            //
            // Because of how we're determining if this was a pop
            // operation, when swiping-to-dismiss iOS 13 modal cards, the
            // `transitionCoordinator` will return the nav controller
            // as the "from" vc, & the nav controller's current child as
            // the "to" vc.
            //
            // We only want to do stuff here if it's an actual
            // navigation pop operation, which in the above
            // scenario, it isn't.
            
            return
            
        }
        
        guard !navigationController.viewControllers.contains(sourceViewController) else { return }
        
        if sourceViewController != coordinator.rootViewController {
            
            // Tell the coordinator we're popping a view controller if it
            // isn't the coordinator's root view controller
            
            coordinator.didPopViewController(sourceViewController)
            
        }
        else {
            
            // We're popping the coordinator's root view controller.
            // Remove self from parent without attempting to dismiss the view controller
            
            (coordinator.parentCoordinator as? ViewCoordinator)?
                .removeForNavigationPop(child: coordinator)
            
        }
        
    }
    
}
