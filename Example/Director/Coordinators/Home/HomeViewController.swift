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
    func homeViewControllerDidTapModalCoordinator(_ viewController: HomeViewController)
    func homeViewControllerDidTapEmbeddedCoordinator(_ viewController: HomeViewController)
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var settingsLabel: UILabel!
    @IBOutlet private weak var modalCardsContentView: UIView!
    @IBOutlet private weak var modalCardsSwitch: UISwitch!
    
    private weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "SwiftUI",
            style: .plain,
            target: self,
            action: #selector(didTapSwiftUI(_:))
        )
        
        self.modalCardsSwitch.addTarget(
            self,
            action: #selector(modalCardsSwitchValueChanged(_:)),
            for: .valueChanged
        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.modalCardsSwitch.isOn = Settings.shared.cardPresentation
        
    }
    
    func setup(delegate: HomeViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @objc private func modalCardsSwitchValueChanged(_ sender: UISwitch) {
        Settings.shared.cardPresentation = sender.isOn
    }
    
    @objc private func didTapSwiftUI(_ sender: UIBarButtonItem) {
        self.delegate?.homeViewControllerDidTapSwiftUI(self)
    }
    
    @IBAction private func didTapDetailCoordinator(_ sender: UIButton) {
        self.delegate?.homeViewControllerDidTapDetail(self)
    }
    
    @IBAction private func didTapModalCoordinator(_ sender: UIButton) {
        self.delegate?.homeViewControllerDidTapModalCoordinator(self)
    }
    
    @IBAction private func didTapEmbeddedCoordinator(_ sender: UIButton) {
        self.delegate?.homeViewControllerDidTapEmbeddedCoordinator(self)
    }
    
}
