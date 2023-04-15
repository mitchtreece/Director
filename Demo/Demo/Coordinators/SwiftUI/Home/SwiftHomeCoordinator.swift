//
//  SwiftHomeCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SwiftUI
import Director

class SwiftHomeCoordinator: ViewCoordinator {
    
    override func build() -> UIViewController {
        
        let view = SwiftHomeView(delegate: self)
        return UIHostingController(rootView: view)
        
    }
    
}

extension SwiftHomeCoordinator: SwiftHomeViewDelegate {
    
    func swiftHomeViewDidTapUIKit(_ view: SwiftHomeView) {
        replace(with: HomeCoordinator())
    }
    
}
