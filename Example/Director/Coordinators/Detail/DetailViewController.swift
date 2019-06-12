//
//  DetailViewController.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func detailViewControllerDidTapPush(_ viewController: DetailViewController)
    func detailViewControllerDidTapModalPresentation(_ viewController: DetailViewController)
    func detailViewControllerDidTapModalCoordinator(_ viewController: DetailViewController)
    func detailViewControllerDidTapFinish(_ viewController: DetailViewController)
}

class DetailViewController: UIViewController {
    
    private weak var delegate: DetailViewControllerDelegate?
    
    var count: Int = 1 {
        didSet {
            self.title = "Detail #\(count)"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Push",
            style: .plain,
            target: self,
            action: #selector(didTapPush(_:))
        )
        
    }
    
    func setup(delegate: DetailViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @objc private func didTapPush(_ sender: UIBarButtonItem) {
        self.delegate?.detailViewControllerDidTapPush(self)
    }
    
    @IBAction private func didTapModalPresentation(_ sender: UIButton) {
        self.delegate?.detailViewControllerDidTapModalPresentation(self)
    }
    
    @IBAction private func didTapModalCoordinator(_ sender: UIButton) {
        self.delegate?.detailViewControllerDidTapModalCoordinator(self)
    }
    
    @IBAction private func didTapFinish(_ sender: UIButton) {
        self.delegate?.detailViewControllerDidTapFinish(self)
    }
    
}
