//
//  HomeViewController.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidTapSwiftUI(_ viewController: HomeViewController)
    func homeViewControllerDidTapDetail(_ viewController: HomeViewController)
    func homeViewControllerDidTapModalCoordinator(_ viewController: HomeViewController, cardPresentation: Bool)
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var modalCardsContentView: UIView!
    @IBOutlet private weak var modalCardsSwitch: UISwitch!
    
    private weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if #available(iOS 13, *) {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "SwiftUI",
                style: .plain,
                target: self,
                action: #selector(didTapSwiftUI(_:))
            )
            
        }
        else {
            self.modalCardsContentView.isHidden = true
        }
        
    }
    
    func setup(delegate: HomeViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @objc private func didTapSwiftUI(_ sender: UIBarButtonItem) {
        self.delegate?.homeViewControllerDidTapSwiftUI(self)
    }
    
    @IBAction private func didTapDetailCoordinator(_ sender: UIButton) {
        self.delegate?.homeViewControllerDidTapDetail(self)
    }
    
    @IBAction private func didTapModalCoordinator(_ sender: UIButton) {
        self.delegate?.homeViewControllerDidTapModalCoordinator(self, cardPresentation: self.modalCardsSwitch.isOn)
    }
    
}
