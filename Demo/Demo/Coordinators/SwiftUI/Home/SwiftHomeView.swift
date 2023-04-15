//
//  SwiftHomeView.swift
//  Director_Example
//
//  Created by Mitch Treece on 6/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftUI

protocol SwiftHomeViewDelegate: AnyObject {
    func swiftHomeViewDidTapUIKit(_ view: SwiftHomeView)
}

struct SwiftHomeView : View {
    
    var body: some View {
        
        Text("")
            .navigationBarTitle(Text("SwiftUI"))
            .navigationBarItems(trailing: Button(action: {
                self.delegate?.swiftHomeViewDidTapUIKit(self)
            }, label: {
                Text("UIKit")
            }))
        
    }
    
    private weak var delegate: SwiftHomeViewDelegate?
    
    init(delegate: SwiftHomeViewDelegate) {
        self.delegate = delegate
    }
    
}
