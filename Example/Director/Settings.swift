//
//  Settings.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class Settings {
    
    static let shared = Settings()
    
    var cardPresentation: Bool = true
    
    private init() {
        //
    }
    
}
