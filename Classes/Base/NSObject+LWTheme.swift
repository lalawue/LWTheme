//
//  NSObject+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/17.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

protocol LWThemeObjectNotify : NSObject {
    func lw_callSetterWithValue(); ///< call when theme changed
}

extension NSObject : LWThemeObjectNotify {
    
    fileprivate struct AssociatedKey {
        static var address : UInt8 = 0
    }
    
    func lw_storeValue(_ value : Any?, setter : Selector) -> Void {
        let setterKey = NSStringFromSelector(setter)
        var dict = objc_getAssociatedObject(self, &AssociatedKey.address) as? NSMutableDictionary
        if (dict == nil) {
            dict = NSMutableDictionary(capacity: 2);
            objc_setAssociatedObject(self, &AssociatedKey.address, dict, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        if (value != nil) {
            dict!.setObject(value as Any, forKey: setterKey as NSCopying);
        } else {
            dict!.removeObject(forKey: setterKey)
        }
        
        if (dict!.count > 0) {
            LWThemeManager.sharedInstance.addThemeObject(self)
        } else {
            LWThemeManager.sharedInstance.removeThemeObject(self)
        }
    }
    
    func lw_valueForSetter(_ setter : Selector) -> Any? {
        let dict = objc_getAssociatedObject(self, &AssociatedKey.address) as? NSMutableDictionary
        if ((dict != nil) && (dict!.count > 0)) {
            let setterKey = NSStringFromSelector(setter)
            return dict![setterKey]
        } else {
            return ""
        }
    }

    func lw_colorForPattern(_ colorPattern : String?) -> UIColor? {
        return LWThemeManager.sharedInstance.colorForPattern(colorPattern)
    }
    
    func lw_fontForPattern(_ fontPattern : String?) -> UIFont? {
        return LWThemeManager.sharedInstance.fontForPattern(fontPattern)
    }
    
    func lw_imageNamed(_ name : String?) -> UIImage? {
        return LWThemeManager.sharedInstance.imageNamed(name)
    }
    
    //MARK: Apply
    
    @objc func lw_callSetterWithValue() {
        let dict = objc_getAssociatedObject(self, &AssociatedKey.address) as? NSMutableDictionary
        if (dict != nil) {
            for setterKey in dict!.allKeys {
                let selector = NSSelectorFromString(setterKey as! String)
                if (responds(to: selector)) {
                    perform(selector, with: dict![setterKey])
                }
            }
        }
    }
}
