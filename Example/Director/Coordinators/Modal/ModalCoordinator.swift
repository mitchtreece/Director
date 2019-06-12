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
            .setup(delegate: self)
        
        let nav = UINavigationController(rootViewController: vc)
        
        if #available(iOS 13, *) {
            
            nav.modalPresentationStyle = Settings.shared.cardPresentation ?
                .automatic :
                .fullScreen
            
        }
        
        return nav
        
    }
    
}

extension ModalCoordinator: ModalViewControllerDelegate {
    
    func modalViewControllerDidTapDone(_ viewController: ModalViewController) {
        finish()
    }
    
}
