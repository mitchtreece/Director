//
//  DetailCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Director

class DetailCoordinator: ViewCoordinator {
    
    private var pushCount: Int = 1
    
    override func build() -> UIViewController {
        return createDetail()
    }
    
    private func createDetail() -> DetailViewController {
        
        let vc = (UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController)
            .setup(delegate: self)
        
        vc.count = self.pushCount
        self.pushCount += 1
        return vc
        
    }
    
    override func didPopViewController(_ viewController: UIViewController) {
        self.pushCount -= 1
    }
    
}

extension DetailCoordinator: DetailViewControllerDelegate {
    
    func detailViewControllerDidTapPush(_ viewController: DetailViewController) {
        push(createDetail())
    }
    
    func detailViewControllerDidTapModalPresentation(_ viewController: DetailViewController) {
        
        let vc = (UIStoryboard(name: "Modal", bundle: nil)
            .instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController)
            .setup(color: .white, modal: true, delegate: nil)
        
        let nav = UINavigationController(rootViewController: vc)

        nav.modalPresentationStyle = Settings.shared.cardPresentation ?
            .automatic :
            .fullScreen
        
        modal(nav)
        
    }
    
    func detailViewControllerDidTapModalCoordinator(_ viewController: DetailViewController) {
        
        start(
            child: ModalCoordinator(),
            animated: Settings.shared.startAnimated
        )
        
    }
    
    func detailViewControllerDidTapChildCoordinator(_ viewController: DetailViewController) {
        
        start(
            child: DetailCoordinator(),
            animated: Settings.shared.startAnimated
        )
        
    }
    
    func detailViewControllerDidTapReplace(_ viewController: DetailViewController) {
        replace(with: DetailCoordinator())
    }
    
    func detailViewControllerDidTapFinish(_ viewController: DetailViewController) {
        finish(animated: Settings.shared.finishAnimated)
    }
    
    func detailViewControllerDidTapFinishToRoot(_ viewController: DetailViewController) {
        self.sceneCoordinator.finishToRoot(animated: Settings.shared.finishAnimated)
    }
    
}
