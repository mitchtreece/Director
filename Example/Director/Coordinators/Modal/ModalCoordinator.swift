//
//  ModalCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Director

class ModalCoordinator: ViewCoordinator {

    override func build() -> UIViewController {
        
        let vc = (UIStoryboard(name: "Modal", bundle: nil)
            .instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController)
            .setup(color: .systemBackground, delegate: self)
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = Settings.shared.cardPresentation ?
            .automatic :
            .fullScreen
        
        return nav
        
    }
    
}

extension ModalCoordinator: ModalViewControllerDelegate {
    
    func modalViewControllerDidTapReplace(_ viewController: ModalViewController) {
        replace(with: ModalReplacementCoordinator())
    }
    
    func modalViewControllerDidTapFinish(_ viewController: ModalViewController) {
        finish()
    }
    
    func modalViewControllerDidTapFinishToRoot(_ viewController: ModalViewController) {
        self.sceneCoordinator.finishToRoot()
    }
    
    func modalViewControllerDidTapFinishToRootAndStartChild(_ viewController: ModalViewController) {
                
        self.sceneCoordinator.finishToRoot(animated: true, completion: { sceneCoordinator in
            sceneCoordinator.topCoordinator.start(child: ModalReplacementCoordinator())
        })
        
    }
    
    func modalViewControllerDidTapDone(_ viewController: ModalViewController) {
        finish()
    }
    
}
