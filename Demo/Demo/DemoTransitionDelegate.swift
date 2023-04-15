//
//  DemoTransitionDelegate.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit

class DemoTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DemoTransition()
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DemoTransition()
    }
    
}

private class DemoTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        let container = transitionContext.containerView
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let destVC = transitionContext.viewController(forKey: .to)!
        
        destVC.view.alpha = 0
        destVC.view.frame = transitionContext.finalFrame(for: destVC)
        container.addSubview(destVC.view)
        
        UIView.animate(withDuration: duration, animations: {
            
            destVC.view.alpha = 1
            
        }, completion: { _ in
            
            fromVC.view.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        })
        
    }
    
}
