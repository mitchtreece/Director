//
//  ViewCoordinator+DI.swift
//  Director
//
//  Created by Mitch Treece on 7/6/19.
//

import Swinject

public extension AnyCoordinator /* DI */ {
        
    /// The coordinator's dependency resolver.
    var resolver: Resolver? {
        return self.sceneCoordinator.director.resolver
    }
    
}
