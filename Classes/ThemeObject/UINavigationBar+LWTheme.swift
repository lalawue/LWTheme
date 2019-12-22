//
//  UINavigationBar+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/19.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    @objc public var lw_tintColor: String? {
        
        get {
            return lw_valueForSetter(#selector(setter: UINavigationBar.lw_tintColor)) as? String
        }
        
        set (tintColor) {
            self.tintColor = lw_colorForPattern(tintColor)
            lw_storeValue(tintColor, setter: #selector(setter: UINavigationBar.lw_tintColor))
        }
    }
    
    @available(iOS 7.0, *)
    @objc public var lw_barTintColor: String? {
        
        get {
            return lw_valueForSetter(#selector(setter: UINavigationBar.lw_barTintColor)) as? String
        }
        
        set (tintColor) {
            self.barTintColor = lw_colorForPattern(tintColor)
            lw_storeValue(tintColor, setter: #selector(setter: UINavigationBar.lw_barTintColor))
        }
    }
    
}
