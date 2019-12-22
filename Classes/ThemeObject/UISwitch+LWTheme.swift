//
//  UISwitch+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/22.
//

import UIKit

extension UISwitch {
    
    @objc public var lw_onTintColor : String? {

        get {
            return lw_valueForSetter(#selector(setter: UISwitch.lw_onTintColor)) as? String
        }
        
        set (colorPattern) {
            self.onTintColor = lw_colorForPattern(colorPattern)
            lw_storeValue(colorPattern, setter: #selector(setter: UISwitch.lw_onTintColor))
        }
    }
    
    @objc public var lw_tintColor : String? {
        
        get {
            return lw_valueForSetter(#selector(setter: UISwitch.lw_tintColor)) as? String
        }
        
        set (colorPattern) {
            self.tintColor = lw_colorForPattern(colorPattern)
            lw_storeValue(colorPattern, setter: #selector(setter: UISwitch.lw_tintColor))
        }
    }
    
    @objc public var lw_thumbTintColor : String? {
        
        get {
            return lw_valueForSetter(#selector(setter: UISwitch.lw_thumbTintColor)) as? String
        }
        
        set (colorPattern) {
            self.thumbTintColor = lw_colorForPattern(colorPattern)
            lw_storeValue(colorPattern, setter: #selector(setter: UISwitch.lw_thumbTintColor))
        }
    }
}
