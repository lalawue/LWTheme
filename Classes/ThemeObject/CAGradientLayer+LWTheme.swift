//
//  GradientLayer+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/22.
//

import UIKit

extension CAGradientLayer {
    
    @objc public var lw_colors : [String]? {
        
        get {
            return lw_valueForSetter(#selector(setter: CAGradientLayer.lw_colors)) as? [String]
        }
        
        set (colorPatterns) {
            if ((colorPatterns == nil) || (colorPatterns!.count <= 0)) {
                return
            }
            var colors : [Any] = []
            for pattern in colorPatterns! {
                let colorValue = lw_colorForPattern(pattern)
                if (colorValue != nil) {
                    colors.append(colorValue!.cgColor)
                }
            }
            self.colors = colors
            lw_storeValue(colorPatterns, setter: #selector(setter: CAGradientLayer.lw_colors))
        }
    }

}
