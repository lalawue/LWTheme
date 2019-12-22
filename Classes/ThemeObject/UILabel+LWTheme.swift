//
//  UILabel+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/17.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

extension UILabel {
    
    @objc public var lw_textColor : String? {

        get {
            return lw_valueForSetter(#selector(setter : UILabel.lw_textColor)) as? String
        }
        
        set (colorPattern) {
            self.textColor = lw_colorForPattern(colorPattern)
            lw_storeValue(colorPattern, setter: #selector(setter: UILabel.lw_textColor))
        }
    }
    
    @objc public var lw_font : String? {
        
        get {
            return lw_valueForSetter(#selector(setter: UILabel.lw_font)) as? String
        }
        
        set (fontPattern) {
            self.font = self.lw_fontForPattern(fontPattern)
            lw_storeValue(fontPattern, setter: #selector(setter: UILabel.lw_font))
        }
    }
    
    @objc public func lw_setAttributes(_ attrs: [NSAttributedString.Key : Any]?, range: NSRange) {
        
        if ((attrs == nil) || (attrs!.count < 0) || (self.attributedText == nil)) {
            return
        }
        
        let rangeKey = NSStringFromRange(range)
        var rangeAttrs = lw_getAttrs() ?? [:]
        
        rangeAttrs[rangeKey] = attrs
        lw_storeValue(rangeAttrs, setter: #selector(UILabel.lw_setAttrs(_:)))
        
        let attrString = NSMutableAttributedString.init(attributedString: self.attributedText!)
        attrString.setAttributes(LWAttributedStringUtils.lw_mapAttr(attrs!), range: range)
        self.attributedText = attrString
    }
    
    //MARK: apply
    
    fileprivate func lw_getAttrs() -> [String : [NSAttributedString.Key : Any] ]? {
        return lw_valueForSetter(#selector(UILabel.lw_setAttrs(_:))) as? [String : [NSAttributedString.Key : Any] ]
    }
    
    @objc fileprivate func lw_setAttrs(_ rangeAttrs : [String : [NSAttributedString.Key : Any] ]? ) {
        if ((rangeAttrs == nil) || (rangeAttrs!.count <= 0) || (self.attributedText == nil)) {
            return
        }
        let attrString = NSMutableAttributedString.init(attributedString: self.attributedText!)
        for (rangeKey, attrs) in rangeAttrs! {
            let range = NSRangeFromString(rangeKey)
            attrString.setAttributes(LWAttributedStringUtils.lw_mapAttr(attrs), range: range)
        }
        self.attributedText = attrString
    }

}
