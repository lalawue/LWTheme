//
//  UIImage+LWTheme.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/19.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func lw_tintImageWithColor(_ color : UIColor?, blendMode : CGBlendMode) -> UIImage? {
        if (color == nil) {
            return self
        }
        let frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color!.setFill()
        UIRectFill(frame)
        draw(in: frame, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
}
