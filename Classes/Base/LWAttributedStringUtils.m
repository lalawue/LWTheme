//
//  LWAttributedStringUtils.m
//  LWThemeObjC
//
//  Created by lalawue on 2019/12/22.
//

#import "LWAttributedStringUtils.h"
#import "LWTheme_Tools.h"

@implementation LWAttributedStringUtils

+ (NSDictionary *)lw_mapAttrs:(NSDictionary *)attrs
{
    NSMutableDictionary *mAttrs = [NSMutableDictionary dictionaryWithDictionary:attrs];
    
    for (NSAttributedStringKey attrName in [self lw_colorKeys]) {
        NSString *colorPattern = attrs[attrName];
        if ([colorPattern isKindOfClass:[NSString class]]) {
            UIColor *colorValue = [self lw_colorForPattern:colorPattern];
            [mAttrs setObject:colorValue forKey:attrName];
        }
    }
    
    return mAttrs.copy;
}

+ (NSArray<NSAttributedStringKey> *)lw_colorKeys
{
    static NSArray *colorKeys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorKeys = @[NSForegroundColorAttributeName,
                      NSBackgroundColorAttributeName,
                      NSStrokeColorAttributeName,
                      NSUnderlineColorAttributeName,
                      NSStrikethroughColorAttributeName];
    });
    return colorKeys;
}

@end
