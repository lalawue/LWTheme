//
//  CALayer+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/22.
//

import UIKit

extension CALayer {
    
    @objc public var lw_backgroundColor: String? {
        
        get {
            return lw_valueForSetter(#selector(setter: CALayer.lw_backgroundColor)) as? String
        }
        
        set (colorPattern) {
            self.backgroundColor = lw_colorForPattern(colorPattern)?.cgColor
            lw_storeValue(colorPattern, setter: #selector(setter: CALayer.lw_backgroundColor))
        }
    }
    
    @objc public var lw_borderColor: String? {
        
        get {
            return lw_valueForSetter(#selector(setter: CALayer.lw_borderColor)) as? String
        }
        
        set (colorPattern) {
            self.borderColor = lw_colorForPattern(colorPattern)?.cgColor
            lw_storeValue(colorPattern, setter: #selector(setter: CALayer.lw_borderColor))
        }
    }
    
    @objc public var lw_shadowColor: String? {
        
        get {
            return lw_valueForSetter(#selector(setter: CALayer.lw_shadowColor)) as? String
        }
        
        set (colorPattern) {
            self.shadowColor = lw_colorForPattern(colorPattern)?.cgColor
            lw_storeValue(colorPattern, setter: #selector(setter: CALayer.lw_shadowColor))
        }
    }
}
