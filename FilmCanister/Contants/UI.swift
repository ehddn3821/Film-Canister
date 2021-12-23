//
//  UI.swift
//
//  Created by dwKang on 2020/11/13.
//

import UIKit

struct UI {
    static let dynamicWidth = UIScreen.main.bounds.width * 0.43
    static let dynamicHeight = (UIScreen.main.bounds.width * 0.43) * 1.3
    static var safeTopArea: CGFloat {
        get {
            var area: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                if let padding = window?.safeAreaInsets.top {
                    area = padding
                }
            }
            
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows[0]
                area = window.safeAreaInsets.top
            }
            
            
            return area
        }
    }
    
    static var safeBottomArea: CGFloat {
        get {
            var area: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                if let padding = window?.safeAreaInsets.bottom {
                    area = padding
                }
            }
            
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows[0]
                area = window.safeAreaInsets.bottom
            }
            
            
            return area
        }
    }
    
    static var safeLeftArea: CGFloat {
        get {
            var area: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                if let padding = window?.safeAreaInsets.left {
                    area = padding
                }
            }
            
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows[0]
                area = window.safeAreaInsets.left
            }
            
            
            return area
        }
    }
}
