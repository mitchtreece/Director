//
//  ModalReplacementCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Director

class ModalReplacementCoordinator: ViewCoordinator {

    private let transition = ExampleTransitionDelegate()
    
    override func build() -> UIViewController {
        
        let vc = (UIStoryboard(name: "Modal", bundle: nil)
            .instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController)
            .setup(color: .systemGreen, delegate: self)
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.transitioningDelegate = self.transition
        
        return nav
        
    }
    
}

extension ModalReplacementCoordinator: ModalViewControllerDelegate {
    
    func modalViewControllerDidTapFinish(_ viewController: ModalViewController) {
        finish()
    }
    
    func modalViewControllerDidTapFinishToRoot(_ viewController: ModalViewController) {
        self.sceneCoordinator.finishToRoot()
    }
    
    func modalViewControllerDidTapFinishToRootAndStartChild(_ viewController: ModalViewController) {
        
        self.sceneCoordinator.finishToRoot(animated: true, completion: { sceneCoordinator in
            sceneCoordinator.rootCoordinator.start(child: ModalReplacementCoordinator())
        })
        
    }
    
    func modalViewControllerDidTapReplace(_ viewController: ModalViewController) {
        replace(with: ModalReplacementCoordinator())
    }
    
    func modalViewControllerDidTapDone(_ viewController: ModalViewController) {
        finish()
    }
    
}
