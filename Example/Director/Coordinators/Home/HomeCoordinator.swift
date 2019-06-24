//
//  HomeCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Director

class HomeCoordinator: ViewCoordinator {
    
    override func build() -> UIViewController {
        
        return (UIStoryboard(name: "Home", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController)
            .setup(delegate: self)
        
    }
    
}

extension HomeCoordinator: HomeViewControllerDelegate {
    
    func homeViewControllerDidTapSwiftUI(_ viewController: HomeViewController) {
        replace(with: SwiftHomeCoordinator())
    }
    
    func homeViewControllerDidTapDetail(_ viewController: HomeViewController) {
        start(child: DetailCoordinator())
    }
    
    func homeViewControllerDidTapModalCoordinator(_ viewController: HomeViewController) {
        start(child: ModalCoordinator())
    }
    
    func homeViewControllerDidTapEmbeddedCoordinator(_ viewController: HomeViewController) {
        start(child: EmbeddedCoordinator())
    }
    
}
