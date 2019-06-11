//
//  ExampleSceneCoordinator.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Director

class ExampleSceneCoordinator: SceneCoordinator {
    
    override func build() -> ViewCoordinator {
        return HomeCoordinator()
    }
    
}
