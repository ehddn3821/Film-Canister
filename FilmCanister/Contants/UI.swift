//
//  UI.swift
//
//  Created by dwKang on 2020/11/13.
//

import UIKit

struct UI {
    static var SAFE_AREA_TOP: CGFloat {
        get {
            var area: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
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
    
    static var SAFE_AREA_BOTTOM: CGFloat {
        get {
            var area: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
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
    
    static var SAFE_AREA_LEFT: CGFloat {
        get {
            var area: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
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
