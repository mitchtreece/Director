//
//  SceneDirector+DI.swift
//  Director
//
//  Created by Mitch Treece on 7/6/19.
//

import Swinject

private struct AssociatedKeys {
    static var resolver: UInt8 = 0
}

public extension SceneDirector /* DI */ {
    
    internal var resolver: Resolver? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.resolver) as? Resolver
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.resolver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     Starts the scene director with a dependency resolver.
     
     - Parameter resolver: The dependency resolver.
     - Returns: This scene director instance.
     */
    final func start(with resolver: Resolver) -> Self {
        self.resolver = resolver
        return start()
    }
    
}
