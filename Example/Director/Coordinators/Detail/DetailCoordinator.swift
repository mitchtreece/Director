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
    
    override func build() -> UIViewController {
        return createDetail()
    }
    
    private func createDetail() -> DetailViewController {
        
        return (UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController)
            .setup(delegate: self)
        
    }
    
}

extension DetailCoordinator: DetailViewControllerDelegate {
    
    func detailViewControllerDidTapPush(_ viewController: DetailViewController) {
        
        let vc = createDetail()
        push(vc)
        
    }
    
    func detailViewControllerDidTapFinish(_ viewController: DetailViewController) {
        finish()
    }
    
}
