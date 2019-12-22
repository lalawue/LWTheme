//
//  LWAttributedStringUtils.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/22.
//

import UIKit

class LWAttributedStringUtils {
    
    class func lw_mapAttr(_ attrs : [NSAttributedString.Key : Any]) -> [NSAttributedString.Key : Any]? {
        var mAttrs = NSMutableDictionary.init(dictionary: attrs) as! [NSAttributedString.Key : Any]
        for attrName in self.lw_colorKeys {
            let colorPattern = attrs[attrName]
            if (colorPattern is String) {
                let colorValue = LWThemeManager.sharedInstance.colorForPattern(colorPattern as? String)
                mAttrs[attrName] = colorValue
            }
        }
        return mAttrs
    }
    
    fileprivate static let lw_colorKeys = [NSAttributedString.Key.foregroundColor,
                                           NSAttributedString.Key.backgroundColor,
                                           NSAttributedString.Key.strokeColor,
                                           NSAttributedString.Key.underlineColor,
                                           NSAttributedString.Key.strikethroughColor]

}
