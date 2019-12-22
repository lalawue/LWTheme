//
//  UIView+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/15.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

extension UIView {
    
    @objc public var lw_backgroundColor : String? {
        
        get {
            return lw_valueForSetter(#selector(setter : UIView.lw_backgroundColor)) as? String
        }
        
        set (colorPattern) {
            self.backgroundColor = lw_colorForPattern(colorPattern)
            lw_storeValue(colorPattern, setter: #selector(setter: UIView.lw_backgroundColor))
        }
    }
}
