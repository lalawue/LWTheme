//
//  UIButton+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/18.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

fileprivate class ImageTintColorItem : NSObject {
    var image : UIImage? = nil
    var backgroundImage : UIImage? = nil
    var imageTintColorKey : String? = nil
    var backgroundImageTintColorKey : String? = nil
}

extension UIButton {
    
    @objc public func lw_setTitleColor(_ colorPattern: String?, for state: UIControl.State) {
        let stateKey = NSNumber(value: state.rawValue)
        var dict = lw_getTitleColorDict() ?? [:]

        if (colorPattern != nil) {
            dict[stateKey] = colorPattern!
        } else {
            dict[stateKey] = nil
        }
        
        if (colorPattern != nil) {
            let color = lw_colorForPattern(colorPattern)
            setTitleColor(color, for: state)
        }

        lw_storeValue(dict, setter: #selector(lw_setTitleColorDict(_:)))
    }
    
    @objc public func lw_titleColor(for state: UIControl.State) -> String? {
        return lw_getTitleColorDict()?[NSNumber(value: state.rawValue)]
    }
    
    @objc public func lw_setImage(_ image: UIImage?, tintColor : String?, for state: UIControl.State) {
        let stateKey = NSNumber(value: state.rawValue)
        var dict = lw_getImageStateDict() ?? [:]
        let item = dict[stateKey] ?? ImageTintColorItem()
        
        item.image = image
        item.imageTintColorKey = tintColor

        dict[stateKey] = item
        
        if (tintColor != nil) {
            let color = lw_colorForPattern(tintColor)
            let imageValue = image?.lw_tintImageWithColor(color, blendMode: CGBlendMode.destinationIn)
            setImage(imageValue, for: state)
        }
        
        lw_storeValue(dict, setter: #selector(UIButton.lw_setImageStateDict(_:)))
    }
    
    
    @objc public func lw_setBackgroundImage(_ image: UIImage?, tintColor : String?, for state: UIControl.State) {
        let stateKey = NSNumber(value: state.rawValue)
        var dict = lw_getImageStateDict() ?? [:]
        let item = dict[stateKey] ?? ImageTintColorItem()
        
        item.backgroundImage = image
        item.backgroundImageTintColorKey = tintColor
        
        dict[stateKey] = item
        
        if (tintColor != nil) {
            let color = lw_colorForPattern(tintColor)
            let imageValue = image?.lw_tintImageWithColor(color, blendMode: CGBlendMode.destinationIn)
            setBackgroundImage(imageValue, for: state)
        }
        
        lw_storeValue(dict, setter: #selector(UIButton.lw_setImageStateDict(_:)))
    }
    
    //MARK: Apply
    
    // title color
    fileprivate func lw_getTitleColorDict() -> [NSNumber : String]? {
        return lw_valueForSetter(#selector(UIButton.lw_setTitleColorDict(_:))) as? [NSNumber : String]
    }
    
    @objc fileprivate func lw_setTitleColorDict(_ dict : [NSNumber : String]) {
        for (stateKey, colorPattern) in dict {
            let state = UIControl.State.init(rawValue: stateKey.uintValue)
            let colorValue = lw_colorForPattern(colorPattern)
            setTitleColor(colorValue, for: state)
        }
    }
    
    // image & bacgroundImage tint color for state
    fileprivate func lw_getImageStateDict() -> [NSNumber : ImageTintColorItem]? {
        return lw_valueForSetter(#selector(UIButton.lw_setImageStateDict(_:))) as? [NSNumber : ImageTintColorItem]
    }
    
    @objc fileprivate func lw_setImageStateDict(_ dict : [NSNumber : ImageTintColorItem]) {
        for (stateKey, item) in dict {
            // set image
            if ((item.image != nil) && (item.imageTintColorKey != nil)) {
                let colorValue = lw_colorForPattern(item.imageTintColorKey)
                if (colorValue != nil) {
                    let state = UIControl.State.init(rawValue: stateKey.uintValue)
                    let image = item.image?.lw_tintImageWithColor(colorValue!, blendMode: CGBlendMode.destinationIn)
                    setImage(image, for: state)
                }
            }
            // set background image
            if ((item.backgroundImage != nil) && (item.backgroundImageTintColorKey != nil)) {
                let colorValue = lw_colorForPattern(item.backgroundImageTintColorKey)
                if (colorValue != nil) {
                    let state = UIControl.State.init(rawValue: stateKey.uintValue)
                    let image = item.backgroundImage?.lw_tintImageWithColor(colorValue!, blendMode: CGBlendMode.destinationIn)
                    setBackgroundImage(image, for: state)
                }
            }
        }
    }
}
