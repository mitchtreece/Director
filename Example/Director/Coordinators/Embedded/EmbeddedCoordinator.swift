//
//  EmbeddedCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Director

class EmbeddedCoordinator: ViewCoordinator {
    
    private var embeddedViewController: EmbeddedViewController!
    private var redCoordinator = RedCoordinator()
    private var greenCoordinator = GreenCoordinator()
    private var blueCoordinator = BlueCoordinator()

    override func build() -> UIViewController {
        
        self.embeddedViewController = (UIStoryboard(name: "Embedded", bundle: nil)
            .instantiateViewController(withIdentifier: "EmbeddedViewController") as! EmbeddedViewController)

        self.embeddedViewController.viewControllers = startChildren()
        
        let nav = UINavigationController(rootViewController: self.embeddedViewController)
        
        nav.modalPresentationStyle = Settings.shared.cardPresentation ?
            .automatic :
            .fullScreen
        
        return nav
        
    }
    
    private func startChildren() -> [UIViewController] {
        
        startEmbedded(children: [
            self.redCoordinator,
            self.greenCoordinator,
            self.blueCoordinator
        ])
        
        return [
            self.redCoordinator.rootViewController,
            self.greenCoordinator.rootViewController,
            self.blueCoordinator.rootViewController
        ]
        
    }
    
}
