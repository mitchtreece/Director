//
//  ModalViewController.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func modalViewControllerDidTapReplace(_ viewController: ModalViewController)
    func modalViewControllerDidTapFinish(_ viewController: ModalViewController)
    func modalViewControllerDidTapFinishToRoot(_ viewController: ModalViewController)
    func modalViewControllerDidTapFinishToRootAndStartChild(_ viewController: ModalViewController)

    func modalViewControllerDidTapDone(_ viewController: ModalViewController)
}

class ModalViewController: UIViewController {
    
    @IBOutlet private weak var replaceButton: UIButton!
    @IBOutlet private weak var finishButton: UIButton!
    @IBOutlet private weak var finishAllButton: UIButton!
    @IBOutlet private weak var finishAllAndStartButton: UIButton!

    private var doneBarButtonItem: UIBarButtonItem!
    private var isModal: Bool = false
    
    private weak var delegate: ModalViewControllerDelegate?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.doneBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone(_:))
        )
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = self.isModal ? self.doneBarButtonItem : nil
        self.replaceButton.isHidden = self.isModal
        self.finishButton.isHidden = self.isModal
        self.finishAllButton.isHidden = self.isModal
        self.finishAllAndStartButton.isHidden = self.isModal
        
    }
    
    func setup(color: UIColor, modal: Bool = false, delegate: ModalViewControllerDelegate?) -> Self {
        
        self.view.backgroundColor = color
        self.isModal = modal
        self.delegate = delegate
        return self
        
    }
    
    @IBAction private func didTapReplace(_ sender: UIButton) {
        self.delegate?.modalViewControllerDidTapReplace(self)
    }
    
    @IBAction private func didTapFinish(_ sender: UIButton) {
        self.delegate?.modalViewControllerDidTapFinish(self)
    }
    
    @IBAction private func didTapFinishToRoot(_ sender: UIButton) {
        self.delegate?.modalViewControllerDidTapFinishToRoot(self)
    }
    
    @IBAction private func didTapFinishToRootAndStartChild(_ sender: UIButton) {
        self.delegate?.modalViewControllerDidTapFinishToRootAndStartChild(self)
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        
        if let delegate = self.delegate {
            delegate.modalViewControllerDidTapDone(self)
        }
        else {
            
            self.dismiss(
                animated: true,
                completion: nil
            )
            
        }
        
    }
    
}
