//
//  ViewCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

open class ViewCoordinator: AnyCoordinator, Equatable {
    
    public static func == (lhs: ViewCoordinator, rhs: ViewCoordinator) -> Bool {
        lhs === rhs
    }
    
    public internal(set) var parentCoordinator: AnyCoordinator!
    public internal(set) var rootViewController: UIViewController!
    public internal(set) var navigationController: UINavigationController!
    
    internal var presentationDelegate: ViewCoordinatorPresentationDelegate!
    
    internal private(set) var children = [ViewCoordinator]()
    internal var isFinishedAndRemoved: Bool = false
    
    // MARK: Public
    
    public required init() {
        self.presentationDelegate = ViewCoordinatorPresentationDelegate(coordinator: self)
    }
    
    open func build() -> UIViewController {
        fatalError("ViewCoordinator must return a view controller")
    }
    
    open func didStart() {
        // Override
    }
    
    open func didFinish() {
        // Override
    }
    
    public final func start(child coordinator: ViewCoordinator, animated: Bool = true, embedded: Bool = false) {
        
        // Set properties from parent -> child
        
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.navigationController
        coordinator.navigationController.delegate = coordinator.presentationDelegate
        // coordinator.isEmbedded = embedded
        
        // Set child's root view controller
        
        let viewController = coordinator.build()
        viewController.viewCoordinatorPresentationDelegate = coordinator.presentationDelegate
        coordinator.rootViewController = viewController
        
        // Determine child's navigation controller
        
        if let nav = viewController as? UINavigationController, embedded {
            
            // If child is embedded & it's root is a nav controller,
            // Then it's nav controller should be its own; not its parents
            
            coordinator.navigationController = nav
            
        }
        
        add(child: coordinator)
        
        guard !embedded else {
            
            // If embedded, we should skip presentation logic.
            // Just call didStart(), and return
            
            coordinator.didStart()
            return
            
        }
        
        if let nav = viewController as? UINavigationController {
            
            // Child coordinator is always created with parent's nav controller
            // If the child's root view controller is a nav controller, then we're
            // presenting modally and it's nav controller is it's own
            
            coordinator.navigationController = nav
            
            UIViewController.active(in: self.navigationController)?.present(
                nav,
                animated: animated,
                completion: nil
            )
            
        }
        else {
            
            guard animated else {
                
                self.navigationController.pushViewController(
                    viewController,
                    animated: false
                )
                
                return
                
            }
            
            if let transitioningDelegate = viewController.transitioningDelegate,
                let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
                
                let oldDelegate = self.navigationController.delegate
                self.navigationController.delegate = transitioningNavDelegate
                
                self.navigationController.pushViewController(viewController, completion: {
                    self.navigationController.delegate = oldDelegate
                })
                
                return
                
            }
            
            self.navigationController.pushViewController(
                viewController,
                animated: true
            )
            
        }
        
        coordinator.didStart()
        
    }
    
    public final func replace(with coordinator: ViewCoordinator, animated: Bool = true) {
        
        if let sceneCoordinator = self.parentCoordinator as? SceneCoordinator {

            sceneCoordinator.replaceRoot(
                with: coordinator,
                animated: animated
            )
            
        }
        else {
            
            coordinator.parentCoordinator = self.parentCoordinator
            (self.parentCoordinator as! ViewCoordinator).start(
                child: coordinator,
                animated: animated
            )
            
            finish()
            
        }
        
    }
    
    //    public final func replace(with viewControllers: [UIViewController], animated: Bool = true) {
    //
    //        guard !viewControllers.isEmpty else {
    //            debugLog("Cannot replace a ViewCoordinator's managed view controllers with an empty set")
    //            return
    //        }
    //
    //        let currentViewControllers = self.navigationController.viewControllers
    //
    //        guard let startArrayIndex = currentViewControllers
    //            .firstIndex(of: self.rootViewController) else { return }
    //
    //        let startIndex = Int(startArrayIndex)
    //        var endIndex = (currentViewControllers.count - 1)
    //
    //        if let firstChildRoot = self.children.first?.rootViewController {
    //
    //            guard let endArrayIndex = currentViewControllers
    //                .firstIndex(of: firstChildRoot) else { return }
    //
    //            endIndex = Int(endArrayIndex)
    //
    //        }
    //
    //        var replacementViewControllers = [UIViewController]()
    //        var replacementIndex: Int = 0
    //
    //        for i in 0..<currentViewControllers.count {
    //
    //            var vc = currentViewControllers[i]
    //
    //            if (i >= startIndex) && (i <= endIndex) {
    //                vc = viewControllers[replacementIndex]
    //                replacementIndex += 1
    //            }
    //
    //            replacementViewControllers.append(vc)
    //
    //        }
    //
    //        let newRootViewController = viewControllers.first!
    //        self.rootViewController = newRootViewController
    //
    //        self.navigationDelegate.isEnabled = false
    //
    //        if animated {
    //
    //            self.navigationController.setViewControllers(replacementViewControllers, completion: {
    //                self.navigationDelegate.isEnabled = true
    //            })
    //
    //        }
    //        else {
    //
    //            self.navigationController.setViewControllers(
    //                replacementViewControllers,
    //                animated: false
    //            )
    //
    //            self.navigationDelegate.isEnabled = true
    //
    //        }
    //
    //    }
    
    public final func finish(completion: (()->())? = nil) {
        
        guard !self.isFinishedAndRemoved else { return }
        guard let parent = self.parentCoordinator as? ViewCoordinator else {
            debugLog("Cannot finish a SceneCoordinator's root ViewCoordinator")
            return
        }
        
        parent.remove(
            child: self,
            completion: {
                self.didFinish()
                completion?()
        })
        
    }
    
    // MARK: Private
    
    private func add(child coordinator: ViewCoordinator) {
        
        guard !self.children.contains(coordinator) else { return }
        debugLog("\(self.typeString) += \(coordinator.typeString)")
        self.children.append(coordinator)
        
    }
    
    private func remove(child coordinator: ViewCoordinator,
                        fromNavigationPop: Bool = false,
                        completion: (()->())? = nil) {
        
        guard !coordinator.isFinishedAndRemoved else { return }
        guard let index = self.children.firstIndex(where: { $0 === coordinator }) else { return }
        
        debugLog("\(self.typeString) -= \(coordinator.typeString)")
        self.children.remove(at: index)
        coordinator.isFinishedAndRemoved = true
        
        //        guard !child.isEmbedded else { return }
        self.navigationController.delegate = self.presentationDelegate
        
        guard !fromNavigationPop else {
            completion?()
            return
        }
        
        if let nav = coordinator.rootViewController as? UINavigationController {
            
            nav.dismiss(
                animated: true,
                completion: completion
            )
            
        }
        else if let nav = coordinator.rootViewController.navigationController, nav == self.navigationController {
            
            guard let index = nav.viewControllers.firstIndex(of: coordinator.rootViewController) else { return }
            let destinationViewController = nav.viewControllers[index - 1]
            
            nav.popToViewController(destinationViewController, completion: { _ in
                completion?()
            })
            
        }
        
    }
    
    internal func removeForModalDismiss(child coordinator: ViewCoordinator) {
        remove(child: coordinator)
    }
    
    internal func removeForNavigationPop(child coordinator: ViewCoordinator) {
        
        remove(
            child: coordinator,
            fromNavigationPop: true
        )
        
    }
    
}
