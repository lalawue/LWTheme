//
//  LWThemeManager.swift
//  LWThemeSwift
//
//  Created by lalawue on 2019/12/17.
//  Copyright © 2019 lalawue. All rights reserved.
//

import UIKit

public let kLWThemeModeUpdateNotification = "kLWThemeModeUpdateNotification" ///< notification name

public enum LWThemeMode {
    case Light
    case Dark
}

public class LWThemeManager {

    public static let sharedInstance = LWThemeManager();
    
    public var themeMode : LWThemeMode {
        return _themeMode;
    }
    
    public var isDarkMode : Bool {
        return _themeMode == LWThemeMode.Dark
    }
    
    public func useThemeMode(_ mode : LWThemeMode, themeMap : NSDictionary) {
        _themeMode = mode
        _colorMap = themeMap["Color"] as? [String : String] ?? [:]
        _fontMap = themeMap["Font"] as? [String : String] ?? [:]
        _imageMap = themeMap["Image"] as? [String : String] ?? [:]
        changeThemeForObjects()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLWThemeModeUpdateNotification), object: mode)
    }
    
    public func colorForPattern(_ colorPattern : String?) -> UIColor? {
        if (colorPattern == nil) {
            return nil
        }
        let colorString = _colorMap[colorPattern!] ?? colorPattern!
        let color = UIColor.colorFromHexString(hexString: colorString)
        return color
    }
    
    public func colorStringForPattern(_ colorPattern : String) -> String? {
        return _colorMap[colorPattern]
    }
    
    public func fontForPattern(_ fontPattern : String?) -> UIFont? {
        if (fontPattern != nil) {
            let fontDesc = _fontMap[fontPattern!]
            if (fontDesc != nil && fontDesc!.count > 0) {
                let array = fontDesc!.split(separator: ":")
                if (array.count >= 2) {
                    let fontName = array[0]
                    let fontSize = CGFloat.init( Double(array[1])! )
                    if (fontName.count <= 0 || fontName.elementsEqual("_")) {
                        return UIFont.systemFont(ofSize: fontSize)
                    }
                    if (fontName.lowercased().elementsEqual("bold")) {
                        return UIFont.boldSystemFont(ofSize: fontSize)
                    }
                    if (fontName.lowercased().elementsEqual("italic")) {
                        return UIFont.italicSystemFont(ofSize: fontSize)
                    }
                    return UIFont.init(name: String(fontName), size: fontSize)!
                }
            }
            return UIFont.systemFont(ofSize: 12)
        } else {
            return nil
        }
    }
    
    public func imageNamed(_ name : String? ) -> UIImage? {
        if (name != nil) {
            let imageName = _imageMap[name!]
            if (imageName != nil) {
                return UIImage.init(named: imageName!)
            } else {
                return UIImage.init(named: name!)
            }
        }
        return nil
    }
    
    //MARK:
    
    func addThemeObject(_ themeObject : LWThemeObjectNotify) {
        if (themeObject.responds(to: #selector(LWThemeObjectNotify.lw_callSetterWithValue))) {
            _themeObjects.add(themeObject)
        }
    }
    
    func removeThemeObject(_ themeObject : LWThemeObjectNotify ) {
        _themeObjects.remove(themeObject)
    }
    
    //MARK:

    private init() {
        _themeMode = LWThemeMode.Light;
    }

    fileprivate var _themeMode : LWThemeMode;
    fileprivate var _colorMap = [String : String]()
    fileprivate var _fontMap = [String : String]()
    fileprivate var _imageMap = [String : String]()
    fileprivate var _themeObjects = NSHashTable<AnyObject>(options: NSHashTableWeakMemory)
    
    func changeThemeForObjects() {
        if (_themeObjects.count <= 0) {
            return
        }
        let allObjects = _themeObjects.allObjects
        for obj in allObjects {
            let themeObject = obj
            if (themeObject.responds(to: #selector(LWThemeObjectNotify.lw_callSetterWithValue))) {
                themeObject.lw_callSetterWithValue()
            }
        }
    }
}
