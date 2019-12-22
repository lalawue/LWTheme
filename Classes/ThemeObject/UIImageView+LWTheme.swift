//
//  UIImageView+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/19.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

fileprivate class ImageColorItem : NSObject {
    var image : UIImage? = nil
    var tintColorKey : String? = nil
}

extension UIImageView {
    
    @objc public var lw_imageName : String? {
        
        get {
            return lw_valueForSetter(#selector(setter: UIImageView.lw_imageName)) as? String
        }
        
        set (name) {
            self.image = lw_imageNamed(name)
            lw_storeValue(name, setter: #selector(setter: UIImageView.lw_imageName))
        }
    }
    
    @objc public func lw_setImage(_ image : UIImage?, tintColor : String?) {
        let item = lw_imageTintColorItem() ?? ImageColorItem()
        item.image = image
        item.tintColorKey = tintColor
        if (tintColor != nil) {
            let color = lw_colorForPattern(tintColor)
            self.image = image?.lw_tintImageWithColor(color, blendMode: CGBlendMode.destinationIn)
        } else {
            self.image = image
        }
        lw_storeValue(item, setter: #selector(UIImageView.lw_setImageTintColorItem(_:)))
    }
    
    //MARK: Apply
    
    fileprivate func lw_imageTintColorItem() -> ImageColorItem? {
        return lw_valueForSetter(#selector(UIImageView.lw_setImageTintColorItem(_:))) as? ImageColorItem
    }
    
    @objc fileprivate func lw_setImageTintColorItem(_ item : ImageColorItem) {
        if ((item.image != nil) && (item.tintColorKey != nil)) {
            let color = lw_colorForPattern(item.tintColorKey)
            self.image = item.image?.lw_tintImageWithColor(color, blendMode: CGBlendMode.destinationIn)
        }
    }
}
