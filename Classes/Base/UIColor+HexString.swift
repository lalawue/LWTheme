//
//  UIColor+HexString.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/22.
//  Copyright © 2019 lalawue. All rights reserved.
//

// from: https://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string/7180905#7180905

import UIKit

extension UIColor {
    
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    fileprivate class func colorFromHex3(hex3: UInt16, alpha: CGFloat = 1) -> UIColor {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    fileprivate class func colorFromHex4(hex4: UInt16) -> UIColor {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    fileprivate class func colorFromHex6(hex6: UInt32, alpha: CGFloat = 1) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    fileprivate class func colorFromHex8(hex8: UInt32) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func colorFromHexString(hexString: String) -> UIColor? {
        if (!hexString.hasPrefix("#")) {
            return nil
        }

        let hexString: String = String(hexString[String.Index(utf16Offset: 1, in: hexString)...])
        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            return nil
        }
        
        switch (hexString.count) {
        case 3: return colorFromHex3(hex3: UInt16(hexValue))
        case 4: return colorFromHex4(hex4: UInt16(hexValue))
        case 6: return colorFromHex6(hex6: hexValue)
        case 8: return colorFromHex8(hex8: hexValue)
        default: return nil
        }
    }
}
