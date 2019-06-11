//
//  AnyCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import Foundation

public protocol AnyCoordinator {
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
