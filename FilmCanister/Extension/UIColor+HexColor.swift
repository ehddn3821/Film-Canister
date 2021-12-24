//
//  UIColor+HexColor.swift
//
//  Created by dwKang on 2020/09/22.
//

import UIKit
extension UIColor {
    convenience init(hexColor: UI.HEX_COLOR, alpha: CGFloat = 1.0) {
        
        if hexColor.rawValue.hasPrefix("#") {
            let start = hexColor.rawValue.index(hexColor.rawValue.startIndex, offsetBy: 1)
            let hexColor = String(hexColor.rawValue[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    let mask = 0x000000FF
                    let r = Int(hexNumber >> 16) & mask
                    let g = Int(hexNumber >> 8) & mask
                    let b = Int(hexNumber) & mask
                    let red   = CGFloat(r) / 255
                    let green = CGFloat(g) / 255
                    let blue  = CGFloat(b) / 255
                    
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }

        self.init(red: 255, green: 255, blue: 255, alpha: alpha)
    }
    
    convenience init(hexColor: String, alpha: CGFloat = 1.0) {
        
        if hexColor.hasPrefix("#") {
            let start = hexColor.index(hexColor.startIndex, offsetBy: 1)
            let hexColor = String(hexColor[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    let mask = 0x000000FF
                    let r = Int(hexNumber >> 16) & mask
                    let g = Int(hexNumber >> 8) & mask
                    let b = Int(hexNumber) & mask
                    let red   = CGFloat(r) / 255
                    let green = CGFloat(g) / 255
                    let blue  = CGFloat(b) / 255
                    
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }

        self.init(red: 255, green: 255, blue: 255, alpha: alpha)
    }
}
