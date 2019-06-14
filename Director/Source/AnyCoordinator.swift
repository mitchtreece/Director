//
//  AnyCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import Foundation

/// Protocol describing the base attributes of a coordinator.
public protocol AnyCoordinator: class {
    //
}

internal extension AnyCoordinator {
    
    var typeString: String {
        return String(describing: type(of: self))
    }
    
    func debugLog(_ string: String) {
        print("🎬 \(string)")
    }
    
}
