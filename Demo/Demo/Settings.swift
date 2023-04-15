//
//  Settings.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import Foundation

class Settings {
    
    static let shared = Settings()
    
    var cardPresentation: Bool = true
    var startAnimated: Bool = true
    var finishAnimated: Bool = true
    
    private init() {
        //
    }
    
}
