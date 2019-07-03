//
//  EmbeddedChildViewController.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol EmbeddedChildViewControllerDelegate: class {
    func embeddedChildViewControllerDidTapPush(_ viewController: EmbeddedChildViewController)
    func embeddedChildViewControllerDidTapModal(_ viewController: EmbeddedChildViewController)
    func embeddedChildViewControllerDidTapDone(_ viewController: EmbeddedChildViewController)
}

class EmbeddedChildViewController: UIViewController {
    
    private weak var delegate: EmbeddedChildViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let pushItem = UIBarButtonItem(title: "Push", style: .plain, target: self, action: #selector(didTapPush(_:)))
        let modalItem = UIBarButtonItem(title: "Modal", style: .plain, target: self, action: #selector(didTapModal(_:)))
        self.navigationItem.leftBarButtonItems = [modalItem, pushItem]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone(_:))
        )
        
    }
    
    func setup(delegate: EmbeddedChildViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @objc private func didTapPush(_ sender: UIBarButtonItem) {
        self.delegate?.embeddedChildViewControllerDidTapPush(self)
    }
    
    @objc private func didTapModal(_ sender: UIBarButtonItem) {
        self.delegate?.embeddedChildViewControllerDidTapModal(self)
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        self.delegate?.embeddedChildViewControllerDidTapDone(self)
    }
    
}
