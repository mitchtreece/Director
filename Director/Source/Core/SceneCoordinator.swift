//
//  SceneCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

/**
 A scene coordinator base class.
 
 ```
 class ExampleSceneCoordinator: SceneCoordinator {
 
    override func build() -> ViewCoordinator {
        return RootCoordinator()
    }
 
 }
 ```
 */
open class SceneCoordinator: AnyCoordinator {
    
    internal weak var director: SceneDirector!
    
    private var window: UIWindow {
        return self.director.window
    }
    
    private var navigationController: UINavigationController {
        return self.director.navigationController
    }
    
    public private(set) var rootCoordinator: ViewCoordinator!
    
    /// The scene coordinator's top-most child view cordinator,
    /// or the root view coordinator if no children have been started.
    ///
    /// This ignores embedded child view coordinator.
    public var topCoordinator: ViewCoordinator {
        return topCoordinator(in: self.rootCoordinator)
    }
    
    // MARK: Public
    
    public init() {
        //
    }
    
    /// Builds the scene coordinator's root view coordinator.
    /// This should be overriden by subclasses to return a custom view coordinator.
    ///
    /// This should **never** be called directly.
    ///
    /// - Returns: A `ViewCoordinator` instance.
    open func build() -> ViewCoordinator {
        fatalError("SceneCoordinator must return an initial view coordinator")
    }
    
    /// Removes all children from the scene coordinator's root view coordinator.
    ///
    /// - Parameter animated: Flag indicating if this should be done with an animation; _defaults to true_.
    /// - Parameter completion: An optional completion handler to call after all child view coordinators are removed; _defaults to nil_.
    public final func finishToRoot(animated: Bool = true, completion: ((SceneCoordinator)->())? = nil) {
        
        replaceRootWithRoot(
            animated: animated,
            completion: completion
        )
        
    }
    
    // MARK: Private
    
    private func topCoordinator(in base: ViewCoordinator) -> ViewCoordinator {
        
        guard let lastManagedChild = base.children
            .filter({ !$0.isEmbedded })
            .last else { return base }
        
        return topCoordinator(in: lastManagedChild)
        
    }
    
    internal func buildForDirector() -> ViewCoordinator {
        
        let coordinator = build()
        self.rootCoordinator = coordinator
        return coordinator
        
    }
    
    internal func replaceRoot(with coordinator: ViewCoordinator,
                              animated: Bool,
                              completion: (()->())?) {
            
        let rootContainsChildModals = self.rootCoordinator.containsChildModals
        let replacementRootViewController = coordinator.build()

        guard !(replacementRootViewController is UINavigationController) else {
            fatalError("Cannot replace root coordinator with a modal coordinator (UINavigationController)")
        }
        
        debugLog("\(self.typeString) -(replace)-> \(self.rootCoordinator.typeString) -(with)-> \(coordinator.typeString)")
        self.rootCoordinator.children.forEach { $0.removeForParentReplacement() }
                
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.navigationController
        coordinator.rootViewController = replacementRootViewController

        guard animated else {
            
            DispatchQueue.main.async {
                
                // If performing without an animation, we need to force our replacement
                // logic to be executed immediatey (by throwing it onto the main thread).
                //
                // Because the completion handler is called immediately, starting child
                // modal view coordinators from within the handler can fail to present
                // the view coordinator's `rootViewController` in certain situations.
                //
                // This happens because the view hierarchy still reflects the dirty state
                // when the handler is called.
                //
                // i.e. `coordinator.navigationController.presentedViewController` still
                // might contain the previous (now dismissed) view controller.
                
                self.navigationController.setViewControllers([replacementRootViewController], animated: false)
                
                if rootContainsChildModals {
                    
                    // NOTE: Weird glitch when dismissing an iOS 13 modal card (pageSheet)
                    // without an animation. Seems like a UIKit bug.
                    
                    self.rootCoordinator.navigationController.dismiss(animated: false)
                    
                }
                
                self.rootCoordinator = coordinator
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.didStart()
                
                completion?()
                
            }
            
            return
            
        }
                
        if let transitioningDelegate = replacementRootViewController.transitioningDelegate,
            let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
            self.navigationController.delegate = transitioningNavDelegate
        }
        
        // TODO: Find a way for setViewControllers to use transitionDelegate
        
        let animateNavigation = rootContainsChildModals ? false : animated

        self.navigationController.setViewControllers([replacementRootViewController], animated: animateNavigation, completion: {
            
            if !rootContainsChildModals {
                
                self.rootCoordinator = coordinator
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.didStart()
                completion?()
                
            }
            
        })
        
        if rootContainsChildModals {
            
            self.rootCoordinator.navigationController.dismiss(animated: true, completion: {
                
                self.rootCoordinator = coordinator
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.didStart()
                completion?()
                
            })
            
        }
        
    }
    
    internal func replaceRootWithRoot(animated: Bool, completion: ((SceneCoordinator)->())?) {
        
        let viewController = self.rootCoordinator.rootViewController!
        let containsChildModals = self.rootCoordinator.containsChildModals
        
        guard animated else {
            
            DispatchQueue.main.async {
                
                // If performing without an animation, we need to force our replacement
                // logic to be executed immediatey (by throwing it onto the main thread).
                //
                // Because the completion handler is called immediately, starting child
                // modal view coordinators from within the handler can fail to present
                // the view coordinator's `rootViewController` in certain situations.
                //
                // This happens because the view hierarchy still reflects the dirty state
                // when the handler is called.
                //
                // i.e. `coordinator.navigationController.presentedViewController` still
                // might contain the previous (now dismissed) view controller.
                
                self.navigationController.popToRootViewController(animated: false)
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.children.forEach { $0.removeForParentReplacement() }

                if containsChildModals {
                    
                    // NOTE: Weird glitch when dismissing an iOS 13 modal card (pageSheet)
                    // without an animation. Seems like a UIKit bug.
                    
                    self.rootCoordinator.navigationController.dismiss(animated: false)
                    
                }
                            
                completion?(self)
                
            }

            return
            
        }
                
        if let transitioningDelegate = viewController.transitioningDelegate,
            let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
            self.navigationController.delegate = transitioningNavDelegate
        }
        
        let animateNavigation = containsChildModals ? false : animated
            
        self.navigationController.popToRootViewController(animated: animateNavigation, completion: { _ in
            
            if !containsChildModals {
                
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.children.forEach { $0.removeForParentReplacement() }
                completion?(self)
                
            }
            
        })
        
        if containsChildModals {
            
            self.rootCoordinator.navigationController.dismiss(animated: true, completion: {
                
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                self.rootCoordinator.children.forEach { $0.removeForParentReplacement() }
                completion?(self)
                
            })
            
        }
        
    }
    
}
