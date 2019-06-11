//
//  ModalViewController.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func modalViewControllerDidTapDone(_ viewController: ModalViewController)
}

class ModalViewController: UIViewController {
    
    private weak var delegate: ModalViewControllerDelegate?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone(_:))
        )
        
    }
    
    func setup(delegate: ModalViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        self.delegate?.modalViewControllerDidTapDone(self)
    }
    
}
