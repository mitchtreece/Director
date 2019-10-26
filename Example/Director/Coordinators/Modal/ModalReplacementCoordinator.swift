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

    override func build() -> UIViewController {
        
        let vc = (UIStoryboard(name: "Modal", bundle: nil)
            .instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController)
            .setup(replace: false, delegate: self)
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = Settings.shared.cardPresentation ?
            .automatic :
            .fullScreen
        
        return nav
        
    }
    
}

extension ModalReplacementCoordinator: ModalViewControllerDelegate {
    
    func modalViewControllerDidTapFinish(_ viewController: ModalViewController) {
        //
    }
    
    func modalViewControllerDidTapFinishToRoot(_ viewController: ModalViewController) {
        //
    }
    
    func modalViewControllerDidTapReplace(_ viewController: ModalViewController) {
        //
    }
    
    func modalViewControllerDidTapDone(_ viewController: ModalViewController) {
        finish()
    }
    
}
