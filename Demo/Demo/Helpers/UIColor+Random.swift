//
//  UIColor+Random.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit

extension UIColor /* Random */ {
    
    static var random: UIColor {
        
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        
        return UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: 1
        )
        
    }
    
}
